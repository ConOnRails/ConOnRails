class AddSectionToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :section, index: true
  end
end
