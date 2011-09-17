class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :description

      t.timestamps
    end
  end
end
