# frozen_string_literal: true

class CreateDepartments < ActiveRecord::Migration[4.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :volunteer_id
      t.integer :radio_group_id
      t.integer :radio_allotment

      t.timestamps
    end
  end
end
