# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  item_type  :string           not null
#  item_id    :integer          not null
#  event      :string           not null
#  whodunnit  :string
#  object     :text
#  created_at :datetime
#

class Version < ActiveRecord::Base
  include CurrentConvention
end
