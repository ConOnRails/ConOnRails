# frozen_string_literal: true

class CreateRolesUsersJoinTable < ActiveRecord::Migration[4.2]
  def up
    create_table :roles_users, id: false do |t|
      t.integer :role_id
      t.integer :user_id
    end
    add_index :roles_users, %i[role_id user_id], unique: true
  end

  def down
    remove_index :roles_users, %i[role_id user_id], unique: true
    drop_table :roles_users
  end
end
