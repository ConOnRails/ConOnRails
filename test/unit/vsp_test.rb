# frozen_string_literal: true

# == Schema Information
#
# Table name: vsps
#
#  id         :integer          not null, primary key
#  name       :string
#  notes      :string
#  party      :boolean
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_vsps_on_name  (name) UNIQUE
#

require 'test_helper'

class VspTest < ActiveSupport::TestCase
  context Vsp do
    should validate_presence_of :name
    should validate_uniqueness_of :name
  end
end
