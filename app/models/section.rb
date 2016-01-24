# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Section < ActiveRecord::Base
  has_many :event_sections
  has_many :events, through: :event_sections
  has_many :section_roles
  has_many :roles, through: :section_roles

  validates :name, presence: true, uniqueness: true
end
