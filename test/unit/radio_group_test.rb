# == Schema Information
#
# Table name: radio_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  color      :string(255)
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class RadioGroupTest < ActiveSupport::TestCase
  setup do
    @radio_group     = FactoryGirl.build :blue_man_group
    @bad_radio_group = FactoryGirl.build :radio_group
    @radio           = FactoryGirl.build :valid_blue_radio
  end

  test "can create a group with many radios" do
    group = nil
    assert_difference 'RadioGroup.count' do
      group = FactoryGirl.create :many_blue_men_group
    end
    assert_not_nil group
    assert_equal 42, group.num_radios
  end
end
