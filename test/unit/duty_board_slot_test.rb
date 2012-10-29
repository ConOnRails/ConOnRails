require 'test_helper'

class DutyBoardSlotTest < ActiveSupport::TestCase
  setup do
    @dbs = FactoryGirl.create :valid_duty_board_slot
  end

  should belong_to :duty_board_group
  should have_one :duty_board_assignment
  should validate_presence_of :name
  should validate_presence_of :duty_board_group
  should validate_uniqueness_of :name

end
