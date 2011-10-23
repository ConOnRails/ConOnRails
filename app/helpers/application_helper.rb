module ApplicationHelper
  
  def title
    if not @title.nil?
      " | #{ @title }"
    end
  end

end
