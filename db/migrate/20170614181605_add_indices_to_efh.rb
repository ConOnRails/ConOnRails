class AddIndicesToEfh < ActiveRecord::Migration
  def change
    add_index :event_flag_histories, :event_id
  end
end
