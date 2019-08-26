# frozen_string_literal: true

class AddRoleNameToEntry < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :rolename, :string
  end
end
