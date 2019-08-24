# frozen_string_literal: true

class AddEventToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :event_id, :integer
  end
end
