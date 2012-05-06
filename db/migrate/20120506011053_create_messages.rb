class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :for
      t.string :phone_number
      t.string :room_number
      t.string :hotel
      t.integer :user_id
      t.text :message
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
