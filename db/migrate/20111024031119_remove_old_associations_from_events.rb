# frozen_string_literal: true

class RemoveOldAssociationsFromEvents < ActiveRecord::Migration[4.2]
  def up
    remove_column :events, :event_type_id
    remove_column :events, :event_status_id
  end

  def down
    add_column :events, event_type_id: integer
    add_column :events, event_type_id: integer
  end
end
