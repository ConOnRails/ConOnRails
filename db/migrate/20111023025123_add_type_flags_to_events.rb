# frozen_string_literal: true

class AddTypeFlagsToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :comment, :boolean, default: false
    add_column :events, :flagged, :boolean, default: false
    add_column :events, :post_con, :boolean, default: false
    add_column :events, :quote, :boolean, default: false
    add_column :events, :sticky, :boolean, default: false
    add_column :events, :emergency, :boolean, default: false
    add_column :events, :medical, :boolean, default: false
    add_column :events, :hidden, :boolean, default: false
    add_column :events, :secure, :boolean, default: false
  end
end
