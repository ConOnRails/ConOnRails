require 'test_helper'

class RadioAssignmentTest < ActiveSupport::TestCase
  setup do
    @valid_assignment = FactoryGirl.build :valid_radio_assignment
  end

  test "can add assignment" do
    va = RadioAssignment.new @valid_assignment.attributes
    assert va.valid?
  end
end
