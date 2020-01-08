class AddSmokersParadiseToEventAndEfh < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :smokers_paradise, :boolean, default: false
    add_column :event_flag_histories, :smokers_paradise, :boolean, default: false
  end
end
