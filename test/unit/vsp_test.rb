require 'test_helper'

class VspTest < ActiveSupport::TestCase
  context Vsp do
    should validate_presence_of :name
    should validate_uniqueness_of :name
  end
end
