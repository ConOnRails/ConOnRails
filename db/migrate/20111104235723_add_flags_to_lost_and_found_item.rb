# frozen_string_literal: true

class AddFlagsToLostAndFoundItem < ActiveRecord::Migration[4.2]
  def change
    add_column :lost_and_found_items, :found, :boolean, default: false
    add_column :lost_and_found_items, :returned, :boolean, default: false
  end
end
