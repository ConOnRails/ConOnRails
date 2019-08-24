# frozen_string_literal: true

class AddUserIdToEventFlagHistory < ActiveRecord::Migration
  def change
    add_column :event_flag_histories, :user_id, :integer
  end
end
