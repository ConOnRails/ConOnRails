class AddOrigTimeToEventFlagHistory < ActiveRecord::Migration
  def change
    add_column :event_flag_histories, :orig_time, :timestamp
  end
end
