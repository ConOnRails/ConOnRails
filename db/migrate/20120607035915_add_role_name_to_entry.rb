class AddRoleNameToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :rolename, :string
  end
end
