# frozen_string_literal: true

class AddOrigTimeToEventFlagHistory < ActiveRecord::Migration[4.2]
  def change
    add_column :event_flag_histories, :orig_time, :timestamp
  end
end
