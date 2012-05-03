class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :city
      t.string :state
      t.string :postal
      t.string :country
      t.string :home_phone
      t.string :work_phone
      t.string :other_phone
      t.string :email

      t.timestamps
    end
  end
end
