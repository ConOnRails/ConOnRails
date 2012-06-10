class DutyBoardSlot < ActiveRecord::Base
  audited

  belongs_to :department
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :department
  has_one :duty_board_assignment
end
