# == Schema Information
#
# Table name: departments
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  volunteer_id    :integer
#  radio_group_id  :integer
#  radio_allotment :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Department < ActiveRecord::Base
  attr_accessible :name, :radio_allotment, :radio_group_id, :volunteer_id
  has_paper_trail

#  audited
  belongs_to :volunteer
  belongs_to :radio_group
  validates_presence_of :name
  validates_uniqueness_of :name
#  validates_presence_of :volunteer
  validates_presence_of :radio_group
end
