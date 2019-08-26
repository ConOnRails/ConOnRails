# frozen_string_literal: true

class AddUserIdAndRoleNameToLostAndFoundItems < ActiveRecord::Migration[4.2]
  def change
    add_column :lost_and_found_items, :user_id, :integer
    add_column :lost_and_found_items, :rolename, :string
  end
end
