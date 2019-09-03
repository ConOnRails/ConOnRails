# frozen_string_literal: true

class ChangeRadioNumberToString < ActiveRecord::Migration[4.2]
  def up
    change_column :radios, :number, :string
  end

  def down
    change_column :radios, :number, :int
  end
end
