class CreateEventSections < ActiveRecord::Migration
  def change
    create_table :event_sections do |t|
      t.references :event, index: true, foreign_key: true
      t.references :section, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
