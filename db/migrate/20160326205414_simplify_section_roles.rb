class SimplifySectionRoles < ActiveRecord::Migration
  def change
    add_column :section_roles, :permission_flags, :jsonb, null: false, default: '{}'
    add_index :section_roles, :permission_flags, using: :gin
    remove_column :section_roles, :permission
  end
end
