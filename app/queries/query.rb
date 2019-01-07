module Queries
  class Query
    attr_reader :initial_query, :is

    def initialize(query_so_far)
      @initial_query = query_so_far
    end
  end
end
