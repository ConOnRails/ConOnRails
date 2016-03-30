class SectionUser < ActiveRecord::Base
  belongs_to :section, inverse_of: :section_users
  belongs_to :user, inverse_of: :section_users
end
