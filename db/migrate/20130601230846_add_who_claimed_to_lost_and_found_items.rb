class AddWhoClaimedToLostAndFoundItems < ActiveRecord::Migration
  def change
    add_column :lost_and_found_items, :who_claimed, :string
  end
end
