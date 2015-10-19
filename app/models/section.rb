class Section < ActiveRecord::Base
  has_many :events
  has_many :section_roles
  has_many :roles, through: :section_roles

  validates :name, presence: true, uniqueness: true
end
