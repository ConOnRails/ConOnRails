# frozen_string_literal: true

# == Schema Information
#
# Table name: lost_and_found_items
#
#  id              :integer          not null, primary key
#  category        :string
#  description     :string
#  details         :text
#  where_last_seen :string
#  where_found     :string
#  owner_name      :string
#  owner_contact   :text
#  created_at      :datetime
#  updated_at      :datetime
#  user_id         :integer
#  rolename        :string
#  who_claimed     :string
#

class LostAndFoundItem < ApplicationRecord
  has_paper_trail
  include LostAndFoundStateTags

  belongs_to :user

  RETIRED_CATEGORIES = {
    badge: 'Badges',
    costume_jewelry: 'Costume Jewelry',
    headgear: 'Headgear',
    keys: 'Keys',
    media: 'Media',
    money: 'Money/Cards/ID',
    paper: 'Paper (incl. Reg Packets)',
    phone: 'Phones',
    small_electronics: 'Small Electronics',
    wallet: 'Wallet',
    weapon: 'Weapons/Props'
  }.freeze

  VALID_CATEGORIES = {
    bag: 'Bags',
    bottle: 'Bottles',
    clothing: 'Clothing',
    electronics: 'Electronics',
    glasses: 'Glasses',
    headwear: 'Headwear',
    jewelry: 'Jewelry',
    lockbox: 'Lockbox (Money, ID, Cards, Wallets, Keys, Badges)',
    papers: 'Papers',
    prop: 'Props',
    toy: 'Toys',
    other_not_listed: 'Other Not Listed'
  }.freeze

  class << self
    def categories
      VALID_CATEGORIES
    end
  end

  validates :category, presence: true, allow_blank: false,
                       inclusion: { in: LostAndFoundItem.categories
                                                        .merge(RETIRED_CATEGORIES)
                                                        .values }
  validates :description, presence: true, allow_blank: false

  # These rules are a little complicated but it's worth it to ensure data integrity
  # 1] On create, only one of reported_missing or found can be true, and only the
  # correct fields should be defined
  # 2] It should always be true that certain fields are defined for certain flags
  # 3] These are hard to express using standard validators, but we always want
  # at least one of reported_missing or found to be true, and we want the "opposite"
  # where fields to be empty on create

  validates :where_last_seen, presence: true, allow_blank: false, if: :reported_missing?
  validates :owner_name, presence: true, allow_blank: false, if: :reported_missing?
  validates :where_found, presence: true, allow_blank: false, if: :found?

  validate :creation_state_correct, on: :create
  validate :always_missing_or_found
  validate :created_with_correct_descriptive_fields, on: :create

  def type
    return 'returned' if returned?
    return 'inventoried' if inventoried?
    return 'found' if found?
    return 'missing' if reported_missing?
  end

  def type_name
    type.capitalize
  end

  def always_missing_or_found
    return unless !reported_missing? && !found?

    errors.add :reported_missing, 'must be true if found is false'
    errors.add :found, 'must be true if reported_missing is false'
  end

  def created_with_correct_descriptive_fields
    # This used to enforce only one or the other, but once a missing item has been found,
    # we want both fields
    validate_where_found_empty if reported_missing? && !found?
    validate_where_last_seen_empty if found? && !reported_missing?
  end

  def creation_state_correct
    return unless found? && reported_missing?

    errors.add :reported_missing,
               'Item can be EITHER reported missing OR found on creation, but not both.'
  end

  def validate_where_last_seen_empty
    return if where_last_seen.blank?

    errors.add :where_last_seen, 'expected empty'
  end

  def validate_where_found_empty
    return if where_found.blank?

    errors.add :where_found, 'expected empty'
  end

  # rubocop:disable Metrics/MethodLength
  def self.to_csv(lfis)
    CSV.generate do |csv|
      csv << %w[ID Category Description Year]
      lfis.find_each do |lfi|
        csv << [
          lfi.id,
          lfi.category,
          lfi.description,
          lfi.created_at.year
        ].flatten
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
end
