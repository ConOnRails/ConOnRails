# frozen_string_literal: true

class MoveStateFromRadioAssignmentToRadio < ActiveRecord::Migration[4.2]
  def change
    remove_column :radio_assignments, :state
    add_column :radios, :state, :string, default: :in
  end
end
