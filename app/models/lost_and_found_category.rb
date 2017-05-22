# == Schema Information
#
# Table name: lost_and_found_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LostAndFoundCategory < ActiveRecord::Base
	has_many :load_and_found_items
end
