# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.string :summary
      t.integer :event_type_id
      t.integer :event_status_id

      t.timestamps
    end
  end
end
