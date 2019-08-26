# frozen_string_literal: true

class AddNameIndexToRole < ActiveRecord::Migration[4.2]
  def change
    add_index :roles, :name, unique: true
  end
end
