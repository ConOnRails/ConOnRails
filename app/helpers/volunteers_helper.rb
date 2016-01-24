# == Schema Information
#
# Table name: volunteers
#
#  id                       :integer          not null, primary key
#  first_name               :string(255)
#  middle_name              :string(255)
#  last_name                :string(255)
#  address1                 :string(255)
#  address2                 :string(255)
#  address3                 :string(255)
#  city                     :string(255)
#  state                    :string(255)
#  postal                   :string(255)
#  country                  :string(255)
#  home_phone               :string(255)
#  work_phone               :string(255)
#  other_phone              :string(255)
#  email                    :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  user_id                  :integer
#  can_have_multiple_radios :boolean
#

module VolunteersHelper
  def check_bool( val )
    if val == true
      '<span style="color: #00cc00">&#x2713;</span>'
    else
      '<span style="color: #cc0000">x</span>'
    end
  end
end
