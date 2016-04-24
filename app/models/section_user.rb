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

class SectionUser < ActiveRecord::Base
  belongs_to :section, inverse_of: :section_users
  belongs_to :user, inverse_of: :section_users
end
