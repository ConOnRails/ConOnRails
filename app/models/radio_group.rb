class RadioGroup < ActiveRecord::Base
  audited
  has_many :radios
  validates :name, presence: true, allow_blank: false
  validates :color, inclusion: { in: COLORS, message: "Please select a color!" }

  COLORS = [ "blue", "red", "yellow", "green" ]

  def num_radios
    return self.radios.count
  end

end
