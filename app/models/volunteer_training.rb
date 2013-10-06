# == Schema Information
#
# Table name: volunteer_trainings
#
#  id             :integer          not null, primary key
#  volunteer_id   :integer
#  radio          :boolean          default(FALSE)
#  ops_basics     :boolean          default(FALSE)
#  first_contact  :boolean          default(FALSE)
#  communications :boolean          default(FALSE)
#  dispatch       :boolean          default(FALSE)
#  wandering_host :boolean          default(FALSE)
#  xo             :boolean          default(FALSE)
#  ops_subhead    :boolean          default(FALSE)
#  ops_head       :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class VolunteerTraining < ActiveRecord::Base
  belongs_to :volunteer
#  audited associated_with: :volunteer

  attr_accessible :volunter_id, :radio, :ops_basics, :first_contact, :communications, :dispatch,
                  :wandering_host, :xo, :ops_subhead, :ops_head
end
