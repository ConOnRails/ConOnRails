class AddMergedFromIdsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :merged_from_ids, :string
  end
end
