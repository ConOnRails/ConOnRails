class AddDateIndices < ActiveRecord::Migration
  def change
    add_index :events, :created_at
    add_index :events, :updated_at
    add_index :event_flag_histories, :created_at
    add_index :event_flag_histories, :updated_at
    add_index :entries, :created_at
    add_index :entries, :updated_at
  end
end
