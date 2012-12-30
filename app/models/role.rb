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
