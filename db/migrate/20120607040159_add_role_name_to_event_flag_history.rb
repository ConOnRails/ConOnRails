class AddRoleNameToEventFlagHistory < ActiveRecord::Migration
  def change
    add_column :event_flag_histories, :rolename, :string
  end
end
