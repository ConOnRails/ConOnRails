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

module VolunteerTrainingsHelper
end
