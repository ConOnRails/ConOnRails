# frozen_string_literal: true

module ApplicationHelper
  def title
    "| #{@title}" unless @title.nil?
  end

  def version_number
    '4.3.0'
  end

  def version_name
    'Silly Squid'
  end

  def version_type
    :release # :release:beta
  end

  def get_banner_style
    num_active = Event.current_convention.num_active
    num_active -= Event.current_convention.num_active_secure unless current_user&.rw_secure?

    style = 'normal'
    style = 'active' if num_active.positive?
    if Event.current_convention.num_active_emergencies.positive? || Event.current_convention.num_active_medicals.positive?
      style = 'emergency'
    end

    style
  end

  def get_emerg_button_style
    style = 'btn btn-danger btn-large'
    if Event.num_active_emergencies.positive? || Event.num_active_medicals.positive?
      style = 'reverse'
    end

    style
  end

  def check_bool(val)
    val ? '<span style="color: #00cc00">&#x2713;</span>' : '<span style="color: #cc0000">x</span>'
  end

  def background
    return 'returned' if params[:returned] || @lfi&.returned?
    return 'inventoried' if params[:inventoried] || @lfi&.inventoried?
    return 'missing' if params[:reported_missing] || @lfi&.reported_missing?

    'found' if params[:found] || @lfi&.found?
  end

  def markdown(text)
    if text.present?
      Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true, safe_links_only: true),
                              no_intra_emphasis: true, tables: true, autolink: true, strikethrough: true).render(text).html_safe
    end
  end

  def show_corkboard(tag)
    return (tag == 'dispatcher' && current_role_name.in?(%w[Dispatch Subhead Head])) if current_user

    false
  end

  def tab(text, path, target = '_self')
    id = text.gsub(%r{[ /]}, '-').downcase
    link_to text, path, id: "menu-tab-#{id}", class: 'tab', role: 'presentation', target: target
  end
end
