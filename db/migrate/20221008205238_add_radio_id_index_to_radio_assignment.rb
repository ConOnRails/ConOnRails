class AddRadioIdIndexToRadioAssignment < ActiveRecord::Migration[5.2]
  def change
    add_index :radio_assignments, :radio_id, unique: true
  end
end
