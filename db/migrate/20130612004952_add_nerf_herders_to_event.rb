class AddNerfHerdersToEvent < ActiveRecord::Migration
  def change
    add_column :events, :nerf_herders, :boolean
    add_column :event_flag_histories, :nerf_herders, :boolean, default: false
  end
end
