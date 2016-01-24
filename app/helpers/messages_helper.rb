# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  for          :string(255)
#  phone_number :string(255)
#  room_number  :string(255)
#  hotel        :string(255)
#  user_id      :integer
#  message      :text
#  is_active    :boolean          default(TRUE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

module MessagesHelper
end
