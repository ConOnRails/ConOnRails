class ChangeRadioNumberToString < ActiveRecord::Migration
  def up
    change_column :radios, :number, :string
  end

  def down
    change_column :radios, :number, :int
  end
end
