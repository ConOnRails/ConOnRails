class AddDepartmentsToEventFlagHistories < ActiveRecord::Migration
  def change
    add_column :event_flag_histories, :accessibility_and_inclusion, :boolean, default: false
    add_column :event_flag_histories, :allocations, :boolean, default: false
    add_column :event_flag_histories, :first_advisors, :boolean, default: false
    add_column :event_flag_histories, :member_advocates, :boolean, default: false
    add_column :event_flag_histories, :operations, :boolean, default: false
    add_column :event_flag_histories, :programming, :boolean, default: false
    add_column :event_flag_histories, :registration, :boolean, default: false
    add_column :event_flag_histories, :volunteers_den, :boolean, default: false
  end
end
