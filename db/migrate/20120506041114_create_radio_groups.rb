class CreateRadioGroups < ActiveRecord::Migration
  def change
    create_table :radio_groups do |t|
      t.string :name
      t.string :color
      t.text :notes

      t.timestamps
    end
  end
end
