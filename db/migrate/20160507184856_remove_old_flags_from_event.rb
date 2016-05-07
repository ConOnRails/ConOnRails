class RemoveOldFlagsFromEvent < ActiveRecord::Migration
  def up
    remove_columns :events, :hidden, :secure
  end

  def down
    add_column :events, :hidden, :boolean
    add_column :events, :secure, :boolean
  end
end
