# frozen_string_literal: true

class MoveStateFromRadioAssignmentToRadio < ActiveRecord::Migration
  def change
    remove_column :radio_assignments, :state
    add_column :radios, :state, :string, default: :in
  end
end
