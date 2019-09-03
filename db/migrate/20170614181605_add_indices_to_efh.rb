# frozen_string_literal: true

class AddIndicesToEfh < ActiveRecord::Migration[4.2]
  def change
    add_index :event_flag_histories, :event_id
  end
end
