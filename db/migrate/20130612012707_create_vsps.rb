# frozen_string_literal: true

class CreateVsps < ActiveRecord::Migration[4.2]
  def change
    create_table :vsps do |t|
      t.string :name
      t.boolean :party
      t.string :notes

      t.timestamps
    end
  end
end
