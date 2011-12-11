class LostAndFoundItem < ActiveRecord::Base
  @@VALID_CATEGORIES = {
    badge: "Badge",
    bag: "Bag",
    bottle: "Bottle",
    clothing: "Clothing",
    costume_jewelry: "Costume Jewelry",
    electronics: "Electronics",
    glasses: "Glasses",
    headgear: "Headgear",
    jewelry: "Jewelry",
    keys: "Keys",
    media: "Media",
    money: "Money",
    paper: "Paper",
    phone: "Phone",
    small_electronics: "Small Electronics",
    toy: "Toy",
    wallet: "Wallet",
    weapon: "Weapon",
    other_not_listed: "Other Not Listed"
   }
  
  scope :found, where( found: true )
  scope :mising, where( reported_missing: true )
  
  validates :category, presence: true, allow_blank: false, inclusion: { in: @@VALID_CATEGORIES.values }
  validates :description, presence: true, allow_blank: false
  
  # These rules are a little complicated but it's worth it to ensure data integrity
  # 1] On create, only one of reported_missing or found can be true, and only the 
  # correct fields should be defined
  validates :found, inclusion: { in: [false] }, if: :reported_missing?, on: :create
  validates :reported_missing, inclusion: { in: [false] }, if: :found?, on: :create
  
  # 2] It should always be true that certain fields are defined for certain flags
  validates :where_last_seen, presence: true, allow_blank: false, if: :reported_missing?
  validates :owner_name, presence: true, allow_blank: false, if: :reported_missing?  
  validates :where_found, presence: true, allow_blank: false, if: :found?

  # 3] These are hard to express using standard validators, but we always want
  # at least one of reported_missing or found to be true, and we want the "opposite"
  # where fields to be empty on create
  validate :always_missing_or_found
  validate :created_with_correct_descriptive_fields, on: :create

  def LostAndFoundItem.Categories
    return @@VALID_CATEGORIES
  end
  
  def type
    return 'returned' if returned?
    return 'found' if found?
    return 'missing' if reported_missing?
  end
  
  def Type
    return 'Returned' if returned?
    return 'Found' if found?
    return 'Missing' if reported_missing?
  end
  
  def always_missing_or_found
    if not reported_missing? and not found?
      errors.add :reported_missing, "must be true if found is false"
      errors.add :found, "must be true if reported_missing is false"
    end
  end
  
  def created_with_correct_descriptive_fields
    validate_where_found_empty if reported_missing?
    validate_where_last_seen_empty if found?
  end
    
  def validate_where_last_seen_empty
    if where_last_seen != nil and where_last_seen != ''
      errors.add :where_last_seen, "expected empty"
    end
  end
  
  def validate_where_found_empty
    if where_found != nil and where_found != ''
      errors.add :where_found, "expected empty"
    end
  end
end
