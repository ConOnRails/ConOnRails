class DutyBoardAssignment < ActiveRecord::Base
  audited

  belongs_to :volunteer
  belongs_to :duty_board_slot
  validates_presence_of :volunteer, message: "You must associate with a volunteer"
  validates_presence_of :duty_board_slot, message: "You must associate with a duty board slot"
  validates_length_of :notes, maximum: 255
end
