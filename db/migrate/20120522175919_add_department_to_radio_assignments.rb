class AddDepartmentToRadioAssignments < ActiveRecord::Migration
  def change
    add_column :radio_assignments, :department_id, :integer
  end
end
