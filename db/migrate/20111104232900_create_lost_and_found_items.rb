class CreateLostAndFoundItems < ActiveRecord::Migration
  def change
    create_table :lost_and_found_items do |t|
      t.string :category
      t.string :description
      t.text :details
      t.string :where_last_seen
      t.string :where_found
      t.string :owner_name
      t.text :owner_contact

      t.timestamps
    end
  end
end
