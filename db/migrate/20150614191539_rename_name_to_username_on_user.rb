# frozen_string_literal: true

class RenameNameToUsernameOnUser < ActiveRecord::Migration
  def change
    rename_column :users, :name, :username
  end
end
