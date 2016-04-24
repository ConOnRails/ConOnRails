# == Schema Information
#
# Table name: departments
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  volunteer_id    :integer
#  radio_group_id  :integer
#  radio_allotment :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Department < ActiveRecord::Base
  has_paper_trail

  belongs_to :volunteer
  belongs_to :radio_group
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :radio_group
end
