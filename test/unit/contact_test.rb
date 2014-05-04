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
#  created_at :datetime
#  updated_at :datetime
#  can_text   :boolean          default(FALSE)
#  position   :string(255)
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  context 'Thingy' do
    should validate_presence_of :name
    should_not allow_value("vorch").for :cell_phone
    should allow_value("+1 123 456 7890").for :cell_phone
  end
end
