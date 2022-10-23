# frozen_string_literal: true

module Truthiness
  def truthy?(flag)
    ['true', 'TRUE', true, true, '1', 1].include? flag
  end
end
