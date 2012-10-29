class Department < ActiveRecord::Base
  attr_accessible :name, :radio_allotment, :radio_group_id

  audited
  belongs_to :volunteer
  belongs_to :radio_group
  validates_presence_of :name
  validates_uniqueness_of :name
#  validates_presence_of :volunteer
  validates_presence_of :radio_group
end
