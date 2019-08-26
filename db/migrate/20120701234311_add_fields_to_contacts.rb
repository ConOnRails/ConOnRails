# frozen_string_literal: true

class AddFieldsToContacts < ActiveRecord::Migration[4.2]
  def change
    add_column :contacts, :can_text, :boolean, default: false
    add_column :contacts, :position, :string
  end
end
