class SectionRole < ActiveRecord::Base
  belongs_to :section
  belongs_to :role
  validates :permission, presence: true, uniqueness: { scope: [:section_id, :role_id] }
end
