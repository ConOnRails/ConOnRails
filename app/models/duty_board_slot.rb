# frozen_string_literal: true

# == Schema Information
#
# Table name: duty_board_slots
#
#  id                  :integer          not null, primary key
#  name                :string
#  created_at          :datetime
#  updated_at          :datetime
#  duty_board_group_id :integer
#
# Indexes
#
#  index_duty_board_slots_on_name  (name) UNIQUE
#

class DutyBoardSlot < ApplicationRecord
  has_paper_trail

  belongs_to :duty_board_group
  has_one :duty_board_assignment, dependent: :destroy
  accepts_nested_attributes_for :duty_board_assignment

  validates :name, presence: true
  validates :name, uniqueness: true
end
