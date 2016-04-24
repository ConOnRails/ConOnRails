# == Schema Information
#
# Table name: section_users
#
#  id         :integer          not null, primary key
#  section_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SectionUserTest < ActiveSupport::TestCase
  should belong_to(:section).inverse_of :section_users
  should belong_to(:user).inverse_of :section_users
end
