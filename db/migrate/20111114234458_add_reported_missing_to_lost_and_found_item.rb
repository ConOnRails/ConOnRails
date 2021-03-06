# frozen_string_literal: true

class AddReportedMissingToLostAndFoundItem < ActiveRecord::Migration[4.2]
  def change
    add_column :lost_and_found_items, :reported_missing, :boolean, default: false
  end
end
