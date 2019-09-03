# frozen_string_literal: true

class CreateRadioGroups < ActiveRecord::Migration[4.2]
  def change
    create_table :radio_groups do |t|
      t.string :name
      t.string :color
      t.text :notes

      t.timestamps
    end
  end
end
