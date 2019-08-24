# frozen_string_literal: true

class CreateDutyBoardSlots < ActiveRecord::Migration
  def change
    create_table :duty_board_slots do |t|
      t.string :name
      t.integer :department_id

      t.timestamps
    end
  end
end
