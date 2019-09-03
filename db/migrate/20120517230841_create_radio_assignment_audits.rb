# frozen_string_literal: true

class CreateRadioAssignmentAudits < ActiveRecord::Migration[4.2]
  def change
    create_table :radio_assignment_audits do |t|
      t.integer :radio_id
      t.integer :volunteer_id
      t.string :state

      t.timestamps
    end
  end
end
