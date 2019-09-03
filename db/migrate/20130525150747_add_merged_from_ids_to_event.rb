# frozen_string_literal: true

class AddMergedFromIdsToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :merged_from_ids, :string
  end
end
