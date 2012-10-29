require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  setup do
    @department = FactoryGirl.create :good_department
  end

  should belong_to :volunteer
  should belong_to :radio_group
  should validate_presence_of :name
  should validate_presence_of :radio_group
  should validate_uniqueness_of :name
  should_not validate_presence_of :volunteer
end
