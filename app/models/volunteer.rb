# frozen_string_literal: true

# == Schema Information
#
# Table name: volunteers
#
#  id                       :integer          not null, primary key
#  first_name               :string
#  middle_name              :string
#  last_name                :string
#  address1                 :string
#  address2                 :string
#  address3                 :string
#  city                     :string
#  state                    :string
#  postal                   :string
#  country                  :string
#  home_phone               :string
#  work_phone               :string
#  other_phone              :string
#  email                    :string
#  created_at               :datetime
#  updated_at               :datetime
#  user_id                  :integer
#  can_have_multiple_radios :boolean
#

class Volunteer < ApplicationRecord
  has_paper_trail

  paginates_per 25

  has_one :volunteer_training, dependent: :destroy, autosave: true
  has_many :radio_assignments
  has_many :radios, through: :radio_assignments
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :home_phone, :work_phone, :other_phone,
            format: { allow_blank: true, message: 'must be a valid telephone number.',
                      with: /\A[\(\)0-9\- \+\.]{10,20}\z/ }
  validates_associated :volunteer_training
  validate :at_least_one_phone_number
  accepts_nested_attributes_for :volunteer_training
  scope :radio_volunteers, lambda {
                             joins(:volunteer_training).order(:last_name).where('radio = ?',
                                                                                true)
                           }
  scope :radio_volunteer, lambda { |first, last|
                            joins(:volunteer_training)
                              .order(:last_name).where('first_name ilike ? and last_name ilike ? and radio = ?',
                                                       "#{first}%",
                                                       "#{last}%",
                                                       true)
                          }

  def name
    (first_name ? first_name + ' ' : '') +
      (middle_name ? middle_name + ' ' : '') +
      (last_name || '')
  end

  private

  def at_least_one_phone_number
    if home_phone.blank? &&
       work_phone.blank? &&
       other_phone.blank?
      errors.add :home_phone, 'At least one phone number must be specified'
    end
  end
end
