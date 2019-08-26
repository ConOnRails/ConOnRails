# frozen_string_literal: true

class AddDepartmentToRadioAssignmentAudits < ActiveRecord::Migration[4.2]
  def change
    add_column :radio_assignment_audits, :department_id, :integer
  end
end
