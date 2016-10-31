require 'query'

module Queries
  module EventQueries
    class EventQuery < Query

      def method_missing(name, *args)
        if Event::FLAGS.include? name.to_s
          args[0].where(name => true)
        elsif Event::FLAGS.include? name.to_s.sub(/^not_/, '')
          args[0].where(name.to_s.sub(/^not_/, '') => false)
        elsif name.to_s =~ /^(.*)_or_(.*)/ && Event::FLAGS.include?($1) && Event::FLAGS.include?($2)
          args[0].where("#{$1} = ? OR #{$2} = ?", true, true)
        end
      end

      protected

      # TODO there's now a copy of this on Event. Find a way to unify them.
      def build_from_filters(initial_query, filters)
        new_query = initial_query
        new_query = filters.reduce(initial_query.where.not(created_at: nil)) do |query, key|
          unless key.first == 'order' || key.second == 'all'
            query = query.where(key.first => key.second)
          end
          query
        end if filters.present?
        new_query
      end

      def fix_bool val
        if val.is_a? String
          return true if val == 'true'
          return false if val == 'false'
        end
        val
      end

    end

    class IndexQuery < EventQuery
      def query(filters=nil)
        is_active not_sticky not_secure not_hidden build_from_filters(initial_query, filters)
      end
    end

    class StickyQuery < EventQuery
      def query
        sticky not_secure not_hidden initial_query
      end
    end

    class SecureQuery < EventQuery
      def query
        is_active not_sticky hidden_or_secure initial_query
      end
    end

    class FiltersQuery < EventQuery
      def initialize(query_so_far, filters)
        @filters = filters
        super query_so_far
      end

      def query
        build_from_filters(initial_query, @filters)
      end

    end
  end
end
