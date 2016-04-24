# == Schema Information
#
# Table name: lost_and_found_items
#
#  id              :integer          not null, primary key
#  category        :string(255)
#  description     :string(255)
#  details         :text
#  where_last_seen :string(255)
#  where_found     :string(255)
#  owner_name      :string(255)
#  owner_contact   :text
#  created_at      :datetime
#  updated_at      :datetime
#  user_id         :integer
#  rolename        :string(255)
#  who_claimed     :string(255)
#

module LostAndFoundItemsHelper
  def checkbox( tag, label, checked=false )
    out = check_box_tag tag, '1', checked
    out += label_tag tag, "#{label}"
  end
end
