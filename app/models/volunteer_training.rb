# frozen_string_literal: true

# == Schema Information
#
# Table name: volunteer_trainings
#
#  id             :integer          not null, primary key
#  communications :boolean          default("false")
#  dispatch       :boolean          default("false")
#  first_contact  :boolean          default("false")
#  ops_basics     :boolean          default("false")
#  ops_head       :boolean          default("false")
#  ops_subhead    :boolean          default("false")
#  radio          :boolean          default("false")
#  wandering_host :boolean          default("false")
#  xo             :boolean          default("false")
#  created_at     :datetime
#  updated_at     :datetime
#  volunteer_id   :integer
#

class VolunteerTraining < ApplicationRecord
  has_paper_trail
  belongs_to :volunteer
end
