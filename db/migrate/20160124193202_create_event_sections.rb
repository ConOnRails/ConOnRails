class CreateEventSections < ActiveRecord::Migration
  def change
    create_table :event_sections do |t|
      t.references :event, index: true, foreign_key: true
      t.references :section, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :event_sections, [:event_id, :section_id], unique: true
  end
end
