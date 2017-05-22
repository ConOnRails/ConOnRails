# == Schema Information
#
# Table name: duty_board_assignments
#
#  id                 :integer          not null, primary key
#  duty_board_slot_id :integer
#  notes              :string
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string
#  string             :string
#

require 'test_helper'

class DutyBoardAssignmentTest < ActiveSupport::TestCase
  should belong_to :duty_board_slot
  should validate_presence_of(:name).with_message /must have a name/
  should validate_presence_of(:duty_board_slot).with_message /must associate/
  should validate_length_of(:notes).is_at_most 255
end
