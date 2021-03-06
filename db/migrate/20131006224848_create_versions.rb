# frozen_string_literal: true

class CreateVersions < ActiveRecord::Migration[4.2]
  def self.up
    unless table_exists? :versions
      create_table :versions do |t|
        t.string   :item_type, null: false
        t.integer  :item_id,   null: false
        t.string   :event,     null: false
        t.string   :whodunnit
        t.text     :object
        t.datetime :created_at
      end
    end
    add_index :versions, %i[item_type item_id] unless index_exists? :versions, %i[item_type item_id]
  end

  def self.down
    remove_index :versions, %i[item_type item_id]
    drop_table :versions
  end
end
