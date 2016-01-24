# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  department :string(255)
#  cell_phone :string(255)
#  hotel      :string(255)
#  hotel_room :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  can_text   :boolean          default(FALSE)
#  position   :string(255)
#

module ContactsHelper
end
