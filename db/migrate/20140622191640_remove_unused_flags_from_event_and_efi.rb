class RemoveUnusedFlagsFromEventAndEfi < ActiveRecord::Migration
  def change
    remove_column :events, :quote, :boolean, default: false
    remove_column :events, :comment, :boolean, default: false
    remove_column :events, :flagged, :boolean, default: false

    remove_column :event_flag_histories, :quote, :boolean, default: false
    remove_column :event_flag_histories, :comment, :boolean, default: false
    remove_column :event_flag_histories, :flagged, :boolean, default: false
  end
end
