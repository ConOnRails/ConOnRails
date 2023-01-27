# frozen_string_literal: true

# == Schema Information
#
# Table name: duty_board_groups
#
#  id         :integer          not null, primary key
#  column     :integer
#  name       :string
#  row        :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_duty_board_groups_on_column          (column)
#  index_duty_board_groups_on_name            (name) UNIQUE
#  index_duty_board_groups_on_row             (row)
#  index_duty_board_groups_on_row_and_column  (row,column) UNIQUE
#

class DutyBoardGroup < ApplicationRecord
  has_paper_trail

  ROW_RANGE = (1..4)
  COL_RANGE = (1..4)

  has_many :duty_board_slots, -> { order :name }, dependent: :destroy,
                                                  inverse_of: :duty_board_group
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
