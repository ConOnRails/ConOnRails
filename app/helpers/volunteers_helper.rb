# frozen_string_literal: true

module VolunteersHelper
  def check_bool(val)
    if val == true
      '<span style="color: #00cc00">&#x2713;</span>'
    else
      '<span style="color: #cc0000">x</span>'
    end
  end
end
