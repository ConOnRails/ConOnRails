# frozen_string_literal: true

class RenameDutyBoardSlotToDutyBoardSlotIdOnDutyBoardAssignments < ActiveRecord::Migration
  def change
    rename_column :duty_board_assignments, :duty_board_slot, :duty_board_slot_id
  end
end
