# frozen_string_literal: true

class FixDepartmentIdToDutyBoardGroupIdOnDutyBoardSlot < ActiveRecord::Migration[4.2]
  def change
    rename_column :duty_board_slots, :department_id, :duty_board_group_id
  end
end
