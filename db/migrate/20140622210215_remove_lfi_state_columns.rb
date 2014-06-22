class RemoveLfiStateColumns < ActiveRecord::Migration
  def change
    remove_column :lost_and_found_items, :reported_missing, :boolean, default: false
    remove_column :lost_and_found_items, :found, :boolean, default: false
    remove_column :lost_and_found_items, :returned, :boolean, default: :false
  end
end
