# == Schema Information
#
# Table name: radios
#
#  id             :integer          not null, primary key
#  number         :string(255)
#  notes          :string(255)
#  radio_group_id :integer
#  image_filename :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  state          :string(255)      default("in")
#

module RadiosHelper
end
