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

class Role < ActiveRecord::Base
  attr_accessible :name, :write_entries, :add_lost_and_found, :admin_duty_board, :admin_radios, :admin_schedule,
                  :admin_users, :assign_duty_board_slots, :assign_radios, :assign_shifts, :modify_lost_and_found,
                  :read_hidden_entries, :make_hidden_entries, :read_audits, :rw_secure

  audited
  has_and_belongs_to_many :users

  name_regex = /^[a-zA-Z0-9_ ]*$/
  
  validates :name, presence: true,
                   allow_blank: false,
                   uniqueness: true,
                   length: { maximum: 32 },
                   format: { with: name_regex }


end
