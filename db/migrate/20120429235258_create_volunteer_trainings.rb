class CreateVolunteerTrainings < ActiveRecord::Migration
  def change
    create_table :volunteer_trainings do |t|
      t.integer :volunteer_id
      t.boolean :radio, default: false
      t.boolean :ops_basics, default: false
      t.boolean :first_contact, default: false
      t.boolean :communications, default: false
      t.boolean :dispatch, default: false
      t.boolean :wandering_host, default: false
      t.boolean :xo, default: false
      t.boolean :ops_subhead, default: false
      t.boolean :ops_head, default: false
      t.timestamps
    end
  end
end
