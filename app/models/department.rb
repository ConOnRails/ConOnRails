# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id              :integer          not null, primary key
#  name            :string
#  radio_allotment :integer
#  created_at      :datetime
#  updated_at      :datetime
#  radio_group_id  :integer
#  volunteer_id    :integer
#
# Indexes
#
#  index_departments_on_name  (name) UNIQUE
#

class Department < ApplicationRecord
  has_paper_trail

  belongs_to :volunteer
  belongs_to :radio_group, optional: true
  validates :name, presence: true
  validates :name, uniqueness: true
end
