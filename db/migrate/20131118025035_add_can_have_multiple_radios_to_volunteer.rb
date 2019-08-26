# frozen_string_literal: true

class AddCanHaveMultipleRadiosToVolunteer < ActiveRecord::Migration[4.2]
  def change
    add_column :volunteers, :can_have_multiple_radios, :boolean
  end
end
