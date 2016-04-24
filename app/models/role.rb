# == Schema Information
#
# Table name: roles
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  add_lost_and_found      :boolean
#  modify_lost_and_found   :boolean
#  admin_radios            :boolean
#  assign_radios           :boolean
#  admin_users             :boolean
#  assign_duty_board_slots :boolean
#  admin_duty_board        :boolean
#  created_at              :datetime
#  updated_at              :datetime
#  read_audits             :boolean          default(FALSE)
#

class Role < ActiveRecord::Base
  has_paper_trail

  has_and_belongs_to_many :users

  name_regex = /\A[a-zA-Z0-9_ ]*\z/

  validates :name, presence: true,
                   allow_blank: false,
                   uniqueness: true,
                   length: { maximum: 32 },
                   format: { with: name_regex }
end
