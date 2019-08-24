# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :realname
      t.string :password_digest

      t.timestamps
    end
  end
end
