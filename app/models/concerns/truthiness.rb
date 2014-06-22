module Truthiness
  def is_truthy?(flag)
    ['true', 'TRUE', :true, true, '1', 1].include? flag
  end
end