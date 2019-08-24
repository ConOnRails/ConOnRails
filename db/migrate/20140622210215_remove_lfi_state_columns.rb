# frozen_string_literal: true

class RemoveLfiStateColumns < ActiveRecord::Migration
  def change
    remove_column :lost_and_found_items, :reported_missing, :boolean
    remove_column :lost_and_found_items, :found, :boolean
    remove_column :lost_and_found_items, :returned, :boolean
  end
end
