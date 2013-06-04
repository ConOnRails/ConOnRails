class AddMergedFlagToEventFlagHistory < ActiveRecord::Migration
  def change
    add_column :event_flag_histories, :merged, :boolean
  end
end
