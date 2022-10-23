class AddNumberIndexToRadio < ActiveRecord::Migration[5.2]
  def change
    add_index :radios, :number, unique: true
  end
end
