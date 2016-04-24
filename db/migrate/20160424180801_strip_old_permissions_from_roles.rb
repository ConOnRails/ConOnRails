class StripOldPermissionsFromRoles < ActiveRecord::Migration
  def change
    remove_columns :roles,
                   :write_entries,
                   :read_hidden_entries,
                   :admin_schedule,
                   :assign_shifts,
                   :make_hidden_entries,
                   :rw_secure
  end
end
