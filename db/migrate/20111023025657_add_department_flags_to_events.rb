class AddDepartmentFlagsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :consuite, :boolean
    add_column :events, :hotel, :boolean
    add_column :events, :parties, :boolean
    add_column :events, :volunteers, :boolean
    add_column :events, :dealers, :boolean
    add_column :events, :dock, :boolean
    add_column :events, :merchandise, :boolean
  end
end
