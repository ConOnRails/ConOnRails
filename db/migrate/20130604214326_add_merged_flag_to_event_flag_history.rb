# frozen_string_literal: true

class AddMergedFlagToEventFlagHistory < ActiveRecord::Migration[4.2]
  def change
    add_column :event_flag_histories, :merged, :boolean
  end
end
