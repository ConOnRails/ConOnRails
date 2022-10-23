# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  can_text   :boolean          default("false")
#  cell_phone :string
#  department :string
#  hotel      :string
#  hotel_room :integer
#  name       :string
#  position   :string
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ApplicationRecord
  has_paper_trail

  # audited
  validates :cell_phone,
            format: { message: 'must be a valid telephone number.',
                      with: /\A[()0-9\- +.]{10,20}\z/ }
  validates :name, presence: true, allow_blank: false
end
