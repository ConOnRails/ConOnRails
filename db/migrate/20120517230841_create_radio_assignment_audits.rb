class CreateRadioAssignmentAudits < ActiveRecord::Migration
  def change
    create_table :radio_assignment_audits do |t|
      t.integer :radio_id
      t.integer :volunteer_id
      t.string :state

      t.timestamps
    end
  end
end
