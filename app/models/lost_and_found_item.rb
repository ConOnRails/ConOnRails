class LostAndFoundItem < ActiveRecord::Base
  CATEGORIES = { llama: "Llama" }
  
  validates :category, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :where_last_seen, presence: true, allow_blank: false#, unless: :found?
  validates :where_found, presence: true, allow_blank: false#if: found?

  # To avoid any chance of confusion, items must be created as explicitly
  # lost (found & returned == false), explicitly found but not returned,
  # or explicitly found and returned.
  validates :found, inclusion: { in: [true, false] }, allow_blank: false
  validates :returned, inclusion: { in: [true, false] }, allow_blank: false
end
