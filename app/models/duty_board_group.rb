# frozen_string_literal: true

# == Schema Information
#
# Table name: duty_board_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  row        :integer
#  column     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DutyBoardGroup < ApplicationRecord
  has_paper_trail

  ROW_RANGE = (1..4).freeze
  COL_RANGE = (1..3).freeze

  has_many :duty_board_slots, -> { order :name }, dependent: :destroy
  validates :name, :row, :column, presence: true
  validates :name, uniqueness: true
  validates :row, uniqueness: { scope: :column }
  validates :row, :column, numericality: true
  validates :row, inclusion: { in: ROW_RANGE }
  validates :column, inclusion: { in: COL_RANGE }

  def self.row_range
    ROW_RANGE
  end

  def self.col_range
    COL_RANGE
  end
end
