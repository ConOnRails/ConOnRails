# frozen_string_literal: true

class AddUserToEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :user_id, :integer
  end
end
