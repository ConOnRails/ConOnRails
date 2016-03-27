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

  accepts_nested_attributes_for :section_roles

  validates :name, presence: true, uniqueness: true

  scope :role_can_read, ->(role) { joins(:section_roles).where(section_roles: { role_id: role }).where('section_roles.permission_flags @> ?', { read: true }.to_json) }
  scope :role_can_write, ->(role) { joins(:section_roles).where(section_roles: { role_id: role }).where('section_roles.permission_flags @> ?', { write: true }.to_json) }
  scope :role_can_secure, ->(role) { joins(:section_roles).where(section_roles: { role_id: role }).where('section_roles.permission_flags @> ?', { secure: true }.to_json) }

end
