# frozen_string_literal: true

class CreateDutyBoardAssignments < ActiveRecord::Migration[4.2]
  def change
    create_table :duty_board_assignments do |t|
      t.integer :volunteer_id
      t.integer :duty_board_slot
      t.string :notes

      t.timestamps
    end
  end
end
