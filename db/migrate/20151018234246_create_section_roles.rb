class CreateSectionRoles < ActiveRecord::Migration
  def change
    create_table :section_roles do |t|
      t.references :section, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true
      t.string :permission

      t.timestamps null: false
    end

    add_index :section_roles, [:section_id, :role_id, :permission], unique: true
    add_index :section_roles, [:section_id, :role_id], unique: false
  end
end
