require 'test_helper'

class DutyBoardAssignmentTest < ActiveSupport::TestCase
  setup do
    @volunteer = FactoryGirl.create :valid_volunteer
    @dbs       = FactoryGirl.create :valid_duty_board_slot
  end

  def new_assignment(num_words = 3)
    yield DutyBoardAssignment.new volunteer:       @volunteer,
                                  duty_board_slot: @dbs,
                                  notes:           Faker::Lorem.sentence(num_words)
  end

  test "must have volunteer dbs but not necessarily notes" do
    DutyBoardAssignment.new do |dba|
      assert dba.invalid?, "DBA should have been invalid"
      assert dba.errors[:volunteer].any?
      assert dba.errors[:duty_board_slot].any?
    end
  end

  test "valid construction" do
    new_assignment do |dba|
      assert dba.valid?, "DBA should have been valid"
    end
  end

  test "notes shouldn't be too long" do
    new_assignment 1000 do |dba|
      p dba
      assert dba.invalid?, "DBA should have been invalid"
      assert dba.errors[:notes].any?
    end
  end
end
