# frozen_string_literal: true

class AddNameUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :users, :name, unique: true
  end

  def down
    remove_index :users, :name
  end
end
