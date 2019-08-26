# frozen_string_literal: true

class AddNameUniquenessIndex < ActiveRecord::Migration[4.2]
  def up
    add_index :users, :name, unique: true
  end

  def down
    remove_index :users, :name
  end
end
