# frozen_string_literal: true

class AddDepartmentToRadioAssignments < ActiveRecord::Migration[4.2]
  def change
    add_column :radio_assignments, :department_id, :integer
  end
end
