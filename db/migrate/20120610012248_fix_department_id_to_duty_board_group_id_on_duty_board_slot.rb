class FixDepartmentIdToDutyBoardGroupIdOnDutyBoardSlot < ActiveRecord::Migration
  def change
    rename_column :duty_board_slots, :department_id, :duty_board_group_id
  end
end
