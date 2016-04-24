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

module RolesHelper
  def check_bool( val )
    if val == true
       '<span style="color: #00cc00">&#x2713;</span>'
    else
      '<span style="color: #cc0000">x</span>'
    end
  end
end
