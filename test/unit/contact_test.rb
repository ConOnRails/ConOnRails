require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should_not allow_value("vorch").for :cell_phone
  should allow_value("+1 123 456 7890").for :cell_phone
end
