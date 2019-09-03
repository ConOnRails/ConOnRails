# frozen_string_literal: true

class AddUserIdToVolunteers < ActiveRecord::Migration[4.2]
  def change
    add_column :volunteers, :user_id, :integer
  end
end
