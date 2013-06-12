class CreateVsps < ActiveRecord::Migration
  def change
    create_table :vsps do |t|
      t.string :name
      t.boolean :party
      t.string :notes

      t.timestamps
    end
  end
end
