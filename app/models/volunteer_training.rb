# frozen_string_literal: true

# == Schema Information
#
# Table name: volunteer_trainings
#
#  id             :integer          not null, primary key
#  communications :boolean          default(FALSE)
#  dispatch       :boolean          default(FALSE)
#  first_contact  :boolean          default(FALSE)
#  ops_basics     :boolean          default(FALSE)
#  ops_head       :boolean          default(FALSE)
#  ops_subhead    :boolean          default(FALSE)
#  radio          :boolean          default(FALSE)
#  wandering_host :boolean          default(FALSE)
#  xo             :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  volunteer_id   :integer
#

class VolunteerTraining < ApplicationRecord
  has_paper_trail
  belongs_to :volunteer
end
