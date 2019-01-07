class FixEventFlagDefaults < ActiveRecord::Migration
  def change
    change_column :events, :post_con, :boolean, default: false
    change_column :events, :sticky, :boolean, default: false
    change_column :events, :emergency, :boolean, default: false
    change_column :events, :medical, :boolean, default: false
    change_column :events, :hidden, :boolean, default: false
    change_column :events, :secure, :boolean, default: false
  end
end
