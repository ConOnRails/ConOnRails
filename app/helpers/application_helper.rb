module ApplicationHelper
  
  def title
    if not @title.nil?
      " | #{ @title }"
    end
  end

  def version_number
    0.97
  end

  def version_name
    "Delirious Diplodocus of Doom"
  end

  def get_banner_style
    style = "normal"
    style = "active" if Event.num_active > 0
    style = "messages" if Message.num_active > 0
    style = "emergency" if Event.num_active_emergencies > 0
    
    return style
  end

  def get_emerg_button_style
    style = "not-emerg"
    style = "reverse" if Event.num_active_emergencies > 0

    return style
  end

  def check_bool( val )
    if val == true
      '<span style="color: #00cc00">&#x2713;</span>'
    else
      '<span style="color: #cc0000">x</span>'
    end
  end

  def background
    return "missing" if params[:reported_missing] or (@lfi and @lfi.reported_missing?)
    return "found" if params[:found] or (@lfi and @lfi.found?)
  end
end
