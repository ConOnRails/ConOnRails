# frozen_string_literal: true

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

class Department < ApplicationRecord
  has_paper_trail

  belongs_to :volunteer
  belongs_to :radio_group
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :radio_group, presence: true
end
