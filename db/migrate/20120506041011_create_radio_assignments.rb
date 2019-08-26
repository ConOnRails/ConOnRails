# frozen_string_literal: true

class CreateRadioAssignments < ActiveRecord::Migration[4.2]
  def change
    create_table :radio_assignments do |t|
      t.integer :radio_id
      t.integer :volunteer_id
      t.string :state # This moves to radios in a later migration

      t.timestamps
    end
  end
end
