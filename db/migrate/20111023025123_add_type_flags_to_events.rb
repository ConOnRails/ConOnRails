class AddTypeFlagsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :comment, :boolean
    add_column :events, :flagged, :boolean
    add_column :events, :post_con, :boolean
    add_column :events, :quote, :boolean
    add_column :events, :sticky, :boolean
    add_column :events, :emergency, :boolean
    add_column :events, :medical, :boolean
    add_column :events, :hidden, :boolean
    add_column :events, :secure, :boolean
  end
end
