# frozen_string_literal: true

class CreateLoginLogs < ActiveRecord::Migration
  def change
    create_table :login_logs do |t|
      t.string :user_name
      t.string :role_name
      t.string :comment
      t.string :ip

      t.timestamps
    end
  end
end
