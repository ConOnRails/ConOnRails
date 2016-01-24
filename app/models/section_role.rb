# == Schema Information
#
# Table name: section_roles
#
#  id         :integer          not null, primary key
#  section_id :integer
#  role_id    :integer
#  permission :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SectionRole < ActiveRecord::Base
  belongs_to :section
  belongs_to :role
  validates :permission, presence: true,
            uniqueness: { scope: [:section_id, :role_id] },
            inclusion: { in: %w[read read_secure write] }
end
