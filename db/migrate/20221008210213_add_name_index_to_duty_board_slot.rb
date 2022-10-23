class AddNameIndexToDutyBoardSlot < ActiveRecord::Migration[5.2]
  def change
    add_index :duty_board_slots, :name, unique: true
  end
end
