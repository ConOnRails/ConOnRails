# == Schema Information
#
# Table name: section_roles
#
#  id               :integer          not null, primary key
#  section_id       :integer
#  role_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  permission_flags :jsonb            not null
#

class SectionRole < ActiveRecord::Base
  serialize :permission_flags, HashSerializer

  belongs_to :section
  belongs_to :role

  store_accessor :permission_flags, :read, :write, :secure

  PERMISSIONS = [:read, :write, :secure]

  def read=(val)
    super bool val
  end

  def write=(val)
    super bool val
  end

  def secure=(val)
    super bool val
  end

  private

  def bool(val)
    [true, 'true'].include? val
  end
end
