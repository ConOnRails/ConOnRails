# frozen_string_literal: true

class AddIndexesToDutyBoardGroups < ActiveRecord::Migration[4.2]
  def change
    add_index :duty_board_groups, :row
    add_index :duty_board_groups, :column
    add_index :duty_board_groups, %i[row column], unique: true
  end
end
