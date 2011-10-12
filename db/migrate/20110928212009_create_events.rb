class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :summary
      t.integer :event_type_id
      t.integer :event_status_id

      t.timestamps
    end
  end
end
