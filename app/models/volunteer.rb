# == Schema Information
#
# Table name: volunteers
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  middle_name :string(255)
#  last_name   :string(255)
#  address1    :string(255)
#  address2    :string(255)
#  address3    :string(255)
#  city        :string(255)
#  state       :string(255)
#  postal      :string(255)
#  country     :string(255)
#  home_phone  :string(255)
#  work_phone  :string(255)
#  other_phone :string(255)
#  email       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Volunteer < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name, :address1, :address2, :address3, :city, :state, :postal
  attr_accessible :country, :home_phone, :work_phone, :other_phone, :email, :user_id
  audited
  has_associated_audits
  paginates_per 25

  has_one :volunteer_training, dependent: :destroy, autosave: true
  has_many :radios, through: :radio_assignment
  belongs_to :user

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates_format_of [:home_phone, :work_phone, :other_phone], allow_blank: true, allow_nil: true,
                      message:                                               "must be a valid telephone number.",
                      with:                                                  /^[\(\)0-9\- \+\.]{10,20}$/
  validates_associated :volunteer_training
  validate :at_least_one_phone_number
  accepts_nested_attributes_for :volunteer_training
  scope :radio_volunteers, -> { joins(:volunteer_training).order(:last_name).where("radio = ?", true)}
  scope :radio_volunteer, ->(first, last) {
    joins(:volunteer_training).
        order(:last_name).where("first_name like ? and last_name like ? and radio = ?",
                                "#{first}%",
                                "#{last}%",
                                true) }

  def name
    return (first_name ? first_name + " " : "") +
        (middle_name ? middle_name + " " : "") +
        (last_name ? last_name : "")
  end

  private

  def at_least_one_phone_number
    if (home_phone.nil? or home_phone.empty?) and
        (work_phone.nil? or work_phone.empty?) and
        (other_phone.nil? or other_phone.empty?)
      errors.add :home_phone, "At least one phone number must be specified"
    end
  end
end
