class AddDepartmentsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :accessibility_and_inclusion, :boolean
    add_column :events, :allocations, :boolean
    add_column :events, :first_advisors, :boolean
    add_column :events, :member_advocates, :boolean
    add_column :events, :operations, :boolean
    add_column :events, :programming, :boolean
    add_column :events, :registration, :boolean
    add_column :events, :volunteers_den, :boolean
  end
end
