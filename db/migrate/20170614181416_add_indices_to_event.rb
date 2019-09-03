# frozen_string_literal: true

class AddIndicesToEvent < ActiveRecord::Migration[4.2]
  def change
    add_index :events, :is_active
    add_index :events, :sticky
    add_index :events, :emergency
    add_index :events, :medical
    add_index :events, :secure
    add_index :events, :hotel
  end
end
