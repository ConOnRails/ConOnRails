# == Schema Information
#
# Table name: vsps
#
#  id         :integer          not null, primary key
#  name       :string
#  party      :boolean
#  notes      :string
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class VspTest < ActiveSupport::TestCase
  context Vsp do
    should validate_presence_of :name
    should validate_uniqueness_of :name
  end
end
