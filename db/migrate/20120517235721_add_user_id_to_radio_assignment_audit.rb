# frozen_string_literal: true

class AddUserIdToRadioAssignmentAudit < ActiveRecord::Migration
  def change
    add_column :radio_assignment_audits, :user_id, :integer
  end
end
