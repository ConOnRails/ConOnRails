class AddFlagHiddenAndRwSecureToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :make_hidden_entries, :boolean, default: false
    add_column :roles, :rw_secure, :boolean, default: false
  end
end
