# frozen_string_literal: true

# == Schema Information
#
# Table name: radio_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  color      :string
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class RadioGroupTest < ActiveSupport::TestCase
  setup do
    @radio_group     = FactoryBot.build :blue_man_group
    @bad_radio_group = FactoryBot.build :radio_group
    @radio           = FactoryBot.build :valid_blue_radio
  end

  test 'can create a group with many radios' do
    group = nil
    assert_difference 'RadioGroup.count' do
      group = FactoryBot.create :many_blue_men_group
    end
    assert_not_nil group
    assert_equal 42, group.num_radios
  end
end
