class AddTagToEventStatus < ActiveRecord::Migration
  def change
    add_column :event_statuses, :tag, :string
  end
end
