class RadioGroup < ActiveRecord::Base
  COLORS = [ "blue", "red", "yellow", "green" ]

  audited
  has_many :radios
  validates :name, presence: true, allow_blank: false
  validates :color, inclusion: { in: COLORS, message: "Please select a color!" }


  def num_radios
    return self.radios.count
  end

end
