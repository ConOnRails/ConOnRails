# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  department :string
#  cell_phone :string
#  hotel      :string
#  hotel_room :integer
#  created_at :datetime
#  updated_at :datetime
#  can_text   :boolean          default(FALSE)
#  position   :string
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  context 'Thingy' do
    should validate_presence_of :name
    should_not allow_value("vorch").for :cell_phone
    should allow_value("+1 123 456 7890").for :cell_phone
  end
end
