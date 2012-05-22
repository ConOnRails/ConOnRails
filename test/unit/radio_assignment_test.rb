require 'test_helper'

class RadioAssignmentTest < ActiveSupport::TestCase
  setup do
    @valid_assignment = FactoryGirl.build :valid_radio_assignment
  end

  test "can add assignment" do
    assert_difference 'RadioAssignment.count' do
      @valid_assignment.save
    end
    assert @valid_assignment.valid?
  end
end
