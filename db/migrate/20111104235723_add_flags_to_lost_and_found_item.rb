class AddFlagsToLostAndFoundItem < ActiveRecord::Migration
  def change
    add_column :lost_and_found_items, :found, :boolean, default: false
    add_column :lost_and_found_items, :returned, :boolean, default: false
  end
end
