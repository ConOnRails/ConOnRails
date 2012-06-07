class DutyBoardSlot < ActiveRecord::Base
  belongs_to :department
  validates_uniqueness_of :name
  audited
end
