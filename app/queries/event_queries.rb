require 'query'

module Queries
  module EventQueries
    class EventQuery < Query

      def method_missing(name, *args)
        if Event::FLAGS.include? name.to_s
          args[0].where Squeel::Nodes::KeyPath.new(name).eq(true)
        elsif Event::FLAGS.include? name.to_s.sub(/^not_/, '')
          args[0].where Squeel::Nodes::KeyPath.new(name.to_s.sub(/^not_/, '').to_sym).eq(false)
        elsif name.to_s =~ /^(.*)_or_(.*)/ && Event::FLAGS.include?($1) && Event::FLAGS.include?($2)
          kp1 = Squeel::Nodes::KeyPath.new($1.to_sym).eq(true)
          kp2 = Squeel::Nodes::KeyPath.new($2.to_sym).eq(true)
          args[0].where { (kp1 | kp2) }
        end
      end

      protected

      # TODO there's now a copy of this on Event. Find a way to unify them.
      def build_from_filters(filters)
        filters.reduce(Squeel::Nodes::Stub.new(:created_at).not_eq(nil)) do |query, key|
          unless key.first == 'order'
            query = query.& Squeel::Nodes::KeyPath.new(key.first.to_sym).eq(fix_bool key.second) unless key.second == 'all'
          end
          query
        end if filters.present?
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
        is_active not_sticky initial_query.where { |q| build_from_filters(filters) }
      end
    end

    class StickyQuery < EventQuery
      def query
        sticky initial_query
      end
    end

    class SecureQuery < EventQuery
      def query
        is_active not_sticky initial_query
      end
    end

    class FiltersQuery < EventQuery
      def initialize(query_so_far, filters)
        @filters = filters
        super query_so_far
      end

      def query
        initial_query.where { |q| build_from_filters(@filters) }
      end

    end
  end
end
