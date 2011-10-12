class AddConfidentialFlagToEvents < ActiveRecord::Migration
  def change
    add_column :events, :confidential_flag, :boolean, default: false
  end
end
