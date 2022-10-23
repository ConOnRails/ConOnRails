# frozen_string_literal: true

# == Schema Information
#
# Table name: versions
#
#  id             :integer          not null, primary key
#  event          :string           not null
#  item_subtype   :string
#  item_type      :string           not null
#  object         :text
#  object_changes :text
#  whodunnit      :string
#  created_at     :datetime
#  item_id        :integer          not null
#
# Indexes
#
#  index_versions_on_item_type_and_item_id  (item_type,item_id)
#

class Version < ApplicationRecord
  include CurrentConvention
end
