# frozen_string_literal: true

# == Schema Information
#
# Table name: duty_board_slots
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  duty_board_group_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class DutyBoardSlot < ApplicationRecord
  has_paper_trail

  belongs_to :duty_board_group
  has_one :duty_board_assignment
  accepts_nested_attributes_for :duty_board_assignment

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :duty_board_group_id, presence: true
end
