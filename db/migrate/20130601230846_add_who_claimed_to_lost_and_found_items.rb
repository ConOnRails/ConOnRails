# frozen_string_literal: true

class AddWhoClaimedToLostAndFoundItems < ActiveRecord::Migration[4.2]
  def change
    add_column :lost_and_found_items, :who_claimed, :string
  end
end
