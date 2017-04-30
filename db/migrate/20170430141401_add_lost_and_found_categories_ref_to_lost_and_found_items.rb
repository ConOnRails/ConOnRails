class AddLostAndFoundCategoriesRefToLostAndFoundItems < ActiveRecord::Migration
  def change
    add_reference :lost_and_found_items, :lost_and_found_category, index: true, foreign_key: true
  end
end
