# == Schema Information
#
# Table name: radio_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  color      :string
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#

class RadioGroup < ActiveRecord::Base
  has_paper_trail

  COLORS = [ "blue", "red", "yellow", "green", "black" ]

#  audited
  has_many :radios
  validates :name, presence: true, allow_blank: false
  validates :color, inclusion: { in: COLORS, message: "Please select a color!" }


  def num_radios
    return self.radios.count
  end

end
