# frozen_string_literal: true

class CreateConventions < ActiveRecord::Migration[4.2]
  def change
    create_table :conventions do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
