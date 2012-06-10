class AddUserIdToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :user_id, :integer
  end
end
