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

  scope :sections_for_roles, ->(roles, permissions) { Section.joins(:section_roles).where(section_roles: { role_id: roles.pluck(&:id), permission: permissions }).uniq.order(:id) }

  def add_role!(role, permission)
    if role.is_a? Fixnum
      role = Role.find role
    end
    SectionRole.create! section: self, role: role, permission: permission
  end
end
