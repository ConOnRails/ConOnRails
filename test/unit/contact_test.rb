# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  can_text   :boolean          default("false")
#  cell_phone :string
#  department :string
#  hotel      :string
#  hotel_room :integer
#  name       :string
#  position   :string
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  context 'Thingy' do
    should validate_presence_of :name
    should_not allow_value('vorch').for :cell_phone
    should allow_value('+1 123 456 7890').for :cell_phone
  end
end
