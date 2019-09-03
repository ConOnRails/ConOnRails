# frozen_string_literal: true

class CreateRadios < ActiveRecord::Migration[4.2]
  def change
    create_table :radios do |t|
      t.integer :number
      t.string :notes
      t.integer :group_id
      t.string :image_filename

      t.timestamps
    end
  end
end
