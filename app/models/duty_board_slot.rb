class DutyBoardSlot < ActiveRecord::Base
  audited

  belongs_to :duty_board_group
  has_one :duty_board_assignment
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :duty_board_group
end
