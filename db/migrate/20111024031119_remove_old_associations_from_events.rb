class RemoveOldAssociationsFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :event_type_id
    remove_column :events, :event_status_id
  end

  def down
    add_column :events, event_type_id: integer
    add_column :events, event_type_id: integer
  end
end
