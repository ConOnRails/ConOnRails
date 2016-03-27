# == Schema Information
#
# Table name: roles
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  write_entries           :boolean
#  read_hidden_entries     :boolean
#  add_lost_and_found      :boolean
#  modify_lost_and_found   :boolean
#  admin_radios            :boolean
#  assign_radios           :boolean
#  admin_users             :boolean
#  admin_schedule          :boolean
#  assign_shifts           :boolean
#  assign_duty_board_slots :boolean
#  admin_duty_board        :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  make_hidden_entries     :boolean          default(FALSE)
#  rw_secure               :boolean          default(FALSE)
#  read_audits             :boolean          default(FALSE)
#

module RolesHelper
end
