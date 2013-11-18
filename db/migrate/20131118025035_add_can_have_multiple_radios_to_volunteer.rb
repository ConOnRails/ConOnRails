class AddCanHaveMultipleRadiosToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :can_have_multiple_radios, :boolean
  end
end
