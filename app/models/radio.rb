# frozen_string_literal: true

# == Schema Information
#
# Table name: radios
#
#  id             :integer          not null, primary key
#  image_filename :string
#  notes          :string
#  number         :string
#  state          :string           default("in")
#  created_at     :datetime
#  updated_at     :datetime
#  radio_group_id :integer
#
# Indexes
#
#  index_radios_on_number  (number) UNIQUE
#

class Radio < ApplicationRecord
  has_paper_trail

  belongs_to :radio_group
  has_one :radio_assignment, dependent: :destroy

  validates :number, presence: true, uniqueness: true
  validates :radio_group, associated: true
  validates :state, presence: true, inclusion: { in: %w[in out retired] }

  scope :assigned, -> { where(state: 'out') }
  scope :unassigned, -> { where(state: 'in') }

  def name
    number
  end
end
