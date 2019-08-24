# frozen_string_literal: true

class ChangeDutyBoardAssignmentToFreeformName < ActiveRecord::Migration
  def up
    change_table :duty_board_assignments do |t|
      t.remove :volunteer_id
      t.string :name, :string
    end
  end

  def down
    change_table :duty_board_assignments do |t|
      t.remove :name
      t.references :volunteer
    end
  end
end
