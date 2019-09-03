# frozen_string_literal: true

class AddMergedToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :merged, :boolean
  end
end
