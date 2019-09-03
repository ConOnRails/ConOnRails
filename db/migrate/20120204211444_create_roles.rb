# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :write_entries
      t.boolean :read_hidden_entries
      t.boolean :add_lost_and_found
      t.boolean :modify_lost_and_found
      t.boolean :admin_radios
      t.boolean :assign_radios
      t.boolean :admin_users
      t.boolean :admin_schedule
      t.boolean :assign_shifts
      t.boolean :assign_duty_board_slots
      t.boolean :admin_duty_board

      t.timestamps
    end
  end
end
