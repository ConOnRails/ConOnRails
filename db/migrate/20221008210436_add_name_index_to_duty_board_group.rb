class AddNameIndexToDutyBoardGroup < ActiveRecord::Migration[5.2]
  def change
    add_index :duty_board_groups, :name, unique: true
  end
end
