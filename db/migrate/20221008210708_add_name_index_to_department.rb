class AddNameIndexToDepartment < ActiveRecord::Migration[5.2]
  def change
    add_index :departments, :name, unique: true
  end
end
