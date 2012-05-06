class CreateRadioAssignments < ActiveRecord::Migration
  def change
    create_table :radio_assignments do |t|
      t.integer :radio_id
      t.integer :volunteer_id

      t.timestamps
    end
  end
end
