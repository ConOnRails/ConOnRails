# frozen_string_literal: true

class AddNerfHerdersToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :nerf_herders, :boolean
    add_column :event_flag_histories, :nerf_herders, :boolean, default: false
  end
end
