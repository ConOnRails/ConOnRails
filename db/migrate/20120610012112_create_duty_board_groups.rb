# frozen_string_literal: true

class CreateDutyBoardGroups < ActiveRecord::Migration[4.2]
  def change
    create_table :duty_board_groups do |t|
      t.string :name
      t.integer :row
      t.integer :column

      t.timestamps
    end
  end
end
