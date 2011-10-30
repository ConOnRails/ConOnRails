module ApplicationHelper
  
  def title
    if not @title.nil?
      " | #{ @title }"
    end
  end

  def get_banner_style
    style = "normal"
    style = "active" if Event.num_active > 0
    style = "emergency" if Event.num_active_emergencies > 0
    
    return style
  end
end
