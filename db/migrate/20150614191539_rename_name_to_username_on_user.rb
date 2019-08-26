# frozen_string_literal: true

class RenameNameToUsernameOnUser < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :name, :username
  end
end
