# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  item_type  :string(255)      not null
#  item_id    :integer          not null
#  event      :string(255)      not null
#  whodunnit  :string(255)
#  object     :text
#  created_at :datetime
#

class Version < ActiveRecord::Base
  scope :current_convention, -> () {
    where { |e| (e.created_at >= Convention.most_recent.start_date) &
        (e.created_at <= Convention.most_recent.end_date) } unless Convention.most_recent.blank? }
end
