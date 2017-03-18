class CreateLostAndFoundCategories < ActiveRecord::Migration
  def change
    create_table :lost_and_found_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
