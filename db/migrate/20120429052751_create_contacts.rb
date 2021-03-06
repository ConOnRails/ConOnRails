# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[4.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :department
      t.string :cell_phone
      t.string :hotel
      t.integer :hotel_room

      t.timestamps
    end
  end
end
