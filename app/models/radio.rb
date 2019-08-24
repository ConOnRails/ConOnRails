# frozen_string_literal: true

# == Schema Information
#
# Table name: radios
#
#  id             :integer          not null, primary key
#  number         :string(255)
#  notes          :string(255)
#  radio_group_id :integer
#  image_filename :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  state          :string(255)      default("in")
#

class Radio < ApplicationRecord
  has_paper_trail

  belongs_to :radio_group
  has_one :radio_assignment

  validates :number, presence: true, uniqueness: true
  validates :radio_group_id, presence: true
  validates :radio_group, associated: true
  validates :state, presence: true, inclusion: { in: %w[in out retired] }

  scope :assigned, -> { where(state: 'out') }
  scope :unassigned, -> { where(state: 'in') }

  def name
    number
  end
end
