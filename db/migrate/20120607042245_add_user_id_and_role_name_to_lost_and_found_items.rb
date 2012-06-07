class AddUserIdAndRoleNameToLostAndFoundItems < ActiveRecord::Migration
  def change
    add_column :lost_and_found_items, :user_id, :integer
    add_column :lost_and_found_items, :rolename, :string
  end
end
