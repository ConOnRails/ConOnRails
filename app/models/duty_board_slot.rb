class DutyBoardSlot < ActiveRecord::Base
  audited

  belongs_to :department
  validates_uniqueness_of :name
end
