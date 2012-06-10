class CreateDutyBoardAssignments < ActiveRecord::Migration
  def change
    create_table :duty_board_assignments do |t|
      t.integer :volunteer_id
      t.integer :duty_board_slot
      t.string :notes

      t.timestamps
    end
  end
end
