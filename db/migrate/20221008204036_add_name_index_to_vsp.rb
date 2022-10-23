class AddNameIndexToVsp < ActiveRecord::Migration[5.2]
  def change
    add_index :vsps, :name, unique: true
  end
end
