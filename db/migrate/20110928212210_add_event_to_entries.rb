# frozen_string_literal: true

class AddEventToEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :event_id, :integer
  end
end
