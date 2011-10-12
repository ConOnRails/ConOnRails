class CreateEventStatuses < ActiveRecord::Migration
  def change
    create_table :event_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
