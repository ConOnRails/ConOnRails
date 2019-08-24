# frozen_string_literal: true

# == Schema Information
#
# Table name: lost_and_found_items
#
#  id              :integer          not null, primary key
#  category        :string(255)
#  description     :string(255)
#  details         :text
#  where_last_seen :string(255)
#  where_found     :string(255)
#  owner_name      :string(255)
#  owner_contact   :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  rolename        :string(255)
#  who_claimed     :string(255)
#

class LostAndFoundItem < ApplicationRecord
  has_paper_trail
  include LostAndFoundStateTags

  belongs_to :user

  @@retired_categories = {
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
  }

  @@valid_categories = {
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
  }

  def self.valid_categories
    @@valid_categories
  end

  #   scope :found, -> { where(found: true) }
  #   scope :missing, -> { where(reported_missing: true) }
  #   scope :returned, -> { where(returned: true) }
  #   scope :not_returned, -> { where(returned: false) }
  #   scope :inventory, -> (i) { where(found: true, returned: false) if i }

  validates :category, presence: true, allow_blank: false, inclusion: { in: @@valid_categories.merge(@@retired_categories).values }
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

  def self.categories
    @@valid_categories
  end

  def type
    return 'returned' if returned?
    return 'inventoried' if inventoried?
    return 'found' if found?
    return 'missing' if reported_missing?
  end

  def Type
    type.capitalize
  end

  def always_missing_or_found
    if !reported_missing? && !found?
      errors.add :reported_missing, 'must be true if found is false'
      errors.add :found, 'must be true if reported_missing is false'
    end
  end

  def created_with_correct_descriptive_fields
    # This used to enforce only one or the other, but once a missing item has been found,
    # we want both fields
    validate_where_found_empty if reported_missing? && !found?
    validate_where_last_seen_empty if found? && !reported_missing?
  end

  def creation_state_correct
    if found? && reported_missing?
      errors.add :reported_missing, 'Item can be EITHER reported missing OR found on creation, but not both. INTERNAL LOGIC ERROR'
    end
  end

  def validate_where_last_seen_empty
    if !where_last_seen.nil? && (where_last_seen != '')
      errors.add :where_last_seen, 'expected empty'
    end
  end

  def validate_where_found_empty
    errors.add :where_found, 'expected empty' if !where_found.nil? && (where_found != '')
  end

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
end
