class AddTagToEventType < ActiveRecord::Migration
  def change
    add_column :event_types, :tag, :string
  end
end
