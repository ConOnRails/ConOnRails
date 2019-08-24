# frozen_string_literal: true

# == Schema Information
#
# Table name: vsps
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  party      :boolean
#  notes      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class VspTest < ActiveSupport::TestCase
  context Vsp do
    should validate_presence_of :name
    should validate_uniqueness_of :name
  end
end
