module ApplicationHelper
  
  def title
    if not @title.nil?
      " | #{ @title }"
    end
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
end
