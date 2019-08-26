# frozen_string_literal: true

class CreateEventFlagHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :event_flag_histories do |t|
      t.integer :event_id
      t.boolean :is_active, default: false
      t.boolean :comment, default: false
      t.boolean :flagged, default: false
      t.boolean :post_con, default: false
      t.boolean :quote, default: false
      t.boolean :sticky, default: false
      t.boolean :emergency, default: false
      t.boolean :medical, default: false
      t.boolean :hidden, default: false
      t.boolean :secure, default: false
      t.boolean :consuite, default: false
      t.boolean :hotel, default: false
      t.boolean :parties, default: false
      t.boolean :volunteers, default: false
      t.boolean :dealers, default: false
      t.boolean :dock, default: false
      t.boolean :merchandise, default: false

      t.timestamps
    end
  end
end
