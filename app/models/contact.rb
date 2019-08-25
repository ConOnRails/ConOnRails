# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  department :string
#  cell_phone :string
#  hotel      :string
#  hotel_room :integer
#  created_at :datetime
#  updated_at :datetime
#  can_text   :boolean          default(FALSE)
#  position   :string
#

class Contact < ApplicationRecord
  has_paper_trail

  # audited
  validates :cell_phone,
            format: { message: 'must be a valid telephone number.',
                      with: /\A[\(\)0-9\- \+\.]{10,20}\z/ }
  validates :name, presence: true, allow_blank: false
end
