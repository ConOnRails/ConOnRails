# frozen_string_literal: true

class AddFlagHiddenAndRwSecureToRoles < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :make_hidden_entries, :boolean, default: false
    add_column :roles, :rw_secure, :boolean, default: false
  end
end
