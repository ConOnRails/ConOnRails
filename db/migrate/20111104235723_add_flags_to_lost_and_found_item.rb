class AddFlagsToLostAndFoundItem < ActiveRecord::Migration
  def change
    add_column :lost_and_found_items, :found, :boolean
    add_column :lost_and_found_items, :returned, :boolean
  end
end
