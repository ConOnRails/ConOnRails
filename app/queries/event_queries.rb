# frozen_string_literal: true

require 'query'

module Queries
  module EventQueries
    class EventQuery < Query
      def method_missing(name, *args)
        if Event::FLAGS.include? name.to_s
          args[0].where(name => true)
        elsif Event::FLAGS.include? name.to_s.sub(/^not_/, '')
          args[0].where(name.to_s.sub(/^not_/, '') => false)
        elsif name.to_s =~ /^(.*)_or_(.*)/ && Event::FLAGS.include?(Regexp.last_match(1)) && Event::FLAGS.include?(Regexp.last_match(2))
          args[0].where(Regexp.last_match(1) => true).or(args[0].where(Regexp.last_match(2) => true))
        end
      end

      protected

      # TODO: there's now a copy of this on Event. Find a way to unify them.
      def build_from_filters(filters)
        query = {}
        filters&.each do |key, value|
          query[key.to_sym] = (fix_bool value) unless value == 'all'
        end
        query
      end

      def fix_bool(val)
        if val.is_a? String
          return true if val == 'true'
          return false if val == 'false'
        end
        val
      end
    end

    class IndexQuery < EventQuery
      def query(filters = nil)
        is_active not_sticky not_secure not_hidden(initial_query.where(build_from_filters(filters)))
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
        initial_query.where(build_from_filters(@filters))
      end
    end
  end
end
