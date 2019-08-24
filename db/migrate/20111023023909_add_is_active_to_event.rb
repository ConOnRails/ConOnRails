# frozen_string_literal: true

class AddIsActiveToEvent < ActiveRecord::Migration
  def up
    add_column :events, :is_active, :boolean, default: true
  end

  def down
    remove_column :events, :is_active
  end
end
