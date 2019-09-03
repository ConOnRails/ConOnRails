# frozen_string_literal: true

class AddReadAuditsToRole < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :read_audits, :boolean, default: false
  end
end
