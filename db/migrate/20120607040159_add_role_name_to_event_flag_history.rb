# frozen_string_literal: true

class AddRoleNameToEventFlagHistory < ActiveRecord::Migration[4.2]
  def change
    add_column :event_flag_histories, :rolename, :string
  end
end
