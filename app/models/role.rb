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
  has_paper_trail

  has_and_belongs_to_many :users
  has_many :section_roles
  has_many :sections, through: :section_roles

  name_regex = /\A[a-zA-Z0-9_ ]*\z/

  validates :name, presence: true,
                   allow_blank: false,
                   uniqueness: true,
                   length: { maximum: 32 },
                   format: { with: name_regex }


end
