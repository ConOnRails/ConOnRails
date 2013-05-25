class AddMergedToEvent < ActiveRecord::Migration
  def change
    add_column :events, :merged, :boolean
  end
end
