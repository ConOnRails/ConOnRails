require 'test_helper'

class DutyBoardAssignmentTest < ActiveSupport::TestCase
  should belong_to :duty_board_slot
  should validate_presence_of(:name).with_message /must have a name/
  should validate_presence_of(:duty_board_slot).with_message /must associate/
  should ensure_length_of(:notes).is_at_most 255
end
