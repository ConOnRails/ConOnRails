# frozen_string_literal: true

class AddIndicesToEntries < ActiveRecord::Migration[4.2]
  def change
    add_index :entries, :event_id
    add_index :entries, :user_id
  end
end
