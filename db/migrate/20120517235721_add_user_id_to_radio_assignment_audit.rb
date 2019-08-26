# frozen_string_literal: true

class AddUserIdToRadioAssignmentAudit < ActiveRecord::Migration[4.2]
  def change
    add_column :radio_assignment_audits, :user_id, :integer
  end
end
