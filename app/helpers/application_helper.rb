module ApplicationHelper

  def title
    unless @title.nil?
      "| #{ @title }"
    end
  end

  def version_number
    '3.2.2'
  end

  def version_name
    'Hungry Hippopotamus'
  end

  def version_type
    :beta #:release:beta
  end

  def get_banner_style
    style = 'normal'
    style = 'active' if Event.num_active > 0
    style = 'messages' if Message.num_active > 0
    style = 'emergency' if Event.num_active_emergencies > 0 or Event.num_active_medicals > 0

    style
  end

  def get_emerg_button_style
    style = 'not-emerg'
    style = 'reverse' if Event.num_active_emergencies > 0 or Event.num_active_medicals > 0

    style
  end

  def check_bool(val)
    val ? '<span style="color: #00cc00">&#x2713;</span>' : '<span style="color: #cc0000">x</span>'
  end

  def background
    return 'returned' if params[:returned] or (@lfi and @lfi.returned?)
    return 'missing' if params[:reported_missing] or (@lfi and @lfi.reported_missing?)
     'found' if params[:found] or (@lfi and @lfi.found?)
  end

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true, safe_links_only: true),
                            no_intra_emphasis: true, tables: true, autolink: true, strikethrough: true).render(text).html_safe unless text.blank?
  end

  def tab(text, path, target='_self')
    link_to text, path, class: "tab #{tab_selected}", target: target
  end

  def tab_selected

  end

end
