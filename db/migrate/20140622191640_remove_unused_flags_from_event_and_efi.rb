# frozen_string_literal: true

class RemoveUnusedFlagsFromEventAndEfi < ActiveRecord::Migration
  def change
    remove_column :events, :quote, :boolean
    remove_column :events, :comment, :boolean
    remove_column :events, :flagged, :boolean

    remove_column :event_flag_histories, :quote, :boolean
    remove_column :event_flag_histories, :comment, :boolean
    remove_column :event_flag_histories, :flagged, :boolean
  end
end
