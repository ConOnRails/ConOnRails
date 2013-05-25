module ApplicationHelper

  def title
    if not @title.nil?
      " | #{ @title }"
    end
  end

  def version_number
    "1.9.5"
  end

  def version_name
    "Entertained Embellished Egregious Eccentric Ebulient Emu"
  end

  def version_type
    :alpha #:release:beta
  end

  def get_banner_style
    style = "normal"
    style = "active" if Event.num_active > 0
    style = "messages" if Message.num_active > 0
    style = "emergency" if Event.num_active_emergencies > 0 or Event.num_active_medicals > 0

    return style
  end

  def get_emerg_button_style
    style = "not-emerg"
    style = "reverse" if Event.num_active_emergencies > 0 or Event.num_active_medicals > 0

    return style
  end

  def check_bool(val)
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

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true, safe_links_only: true),
                            no_intra_emphasis: true, tables: true, autolink: true, strikethrough: true).render(text).html_safe unless text.blank?
  end
end
