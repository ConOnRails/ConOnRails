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
#  index_duty_board_groups_on_row             (row)
#  index_duty_board_groups_on_row_and_column  (row,column) UNIQUE
#

require 'test_helper'

class DutyBoardGroupTest < ActiveSupport::TestCase
  setup do
    @dbgt = FactoryBot.create :valid_duty_board_group
  end

  should have_many :duty_board_slots
  should validate_presence_of :name
  should validate_presence_of :row
  should validate_presence_of :column
  should validate_uniqueness_of :name
  should validate_numericality_of :row
  should validate_numericality_of :column
  should validate_uniqueness_of(:row).scoped_to :column
  should validate_inclusion_of(:row).in_range DutyBoardGroup.row_range
  should validate_inclusion_of(:column).in_range DutyBoardGroup.col_range
end
