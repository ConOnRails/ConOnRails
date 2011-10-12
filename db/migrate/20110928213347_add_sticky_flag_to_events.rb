class AddStickyFlagToEvents < ActiveRecord::Migration
  def change
    add_column :events, :sticky_flag, :boolean, default: false
  end
end
