class AddDepartmentToRadioAssignmentAudits < ActiveRecord::Migration
  def change
    add_column :radio_assignment_audits, :department_id, :integer
  end
end
