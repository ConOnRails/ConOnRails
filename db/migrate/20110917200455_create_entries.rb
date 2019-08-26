# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :entries do |t|
      t.text :description

      t.timestamps
    end
  end
end
