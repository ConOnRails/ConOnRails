class AddNameIndexToConvention < ActiveRecord::Migration[5.2]
  def change
    add_index :conventions, :name, unique: true
  end
end
