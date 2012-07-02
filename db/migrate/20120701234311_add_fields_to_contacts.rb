class AddFieldsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :can_text, :boolean, default: false
    add_column :contacts, :position, :string
  end
end
