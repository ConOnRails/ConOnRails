# frozen_string_literal: true

module EventsHelper
  def filter_params
    params.permit(filters: [])
  end

  def action_params
    params.permit([:action] + policy(Event).permitted_attributes)
  end

  def create_or_update
    (@event.new_record? ? 'Create a new ' : 'Update a') + ' log entry'
  end

  def filter(term)
    filter_params[:filters][term].presence if filter_params[:filters].present?
  end

  def merge_button
    # We need to know what our path will be before we
    # know what our text will be, so do this first.
    path = merge_button_path

    link_to merge_mode_toggle_text,
            path,
            remote: true,
            class: "btn btn-primary #{merge_toggle_class}",
            type: 'button'
  end

  def merge_button_path
    new_params = toggle_merge_mode(action_params.clone)

    case action_params[:action].to_sym
    when :sticky
      sticky_events_path(new_params)
    when :secure
      secure_events_path(new_params)
    when :review
      review_events_path(new_params)
    else
      events_path(new_params)
    end
  end

  def merge_submit
    return nil if params[:merge_mode] != 'true'

    link_to 'Merge',
            '#',
            class: 'btn btn-success',
            onclick: 'document.getElementById("merge-form").submit()'
  end

  def merge_mode_toggle_text
    return 'Cancel Merge' if params[:merge_mode] == 'true'

    'Merge Events'
  end

  def toggle_merge_mode(new_params)
    new_params[:merge_mode] = new_params[:merge_mode] == 'true' ? 'false' : 'true'
    pp "NORG"
    pp new_params
  end

  def merge_toggle_class
    'cancel-merge' if params[:merge_mode] == 'true'
  end

  def event_style(event)
    ret = String.new
    ret << 'active ' if event.is_active?
    ret << 'medical ' if event.medical?
    ret << 'emergency ' if event.emergency?
    ret << 'sticky ' if event.sticky?
    ret
  end

  def convention_param
    params[:convention] || Convention.current_convention.try(:id)
  end

  def event_tags(event)
    event.tags.collect { |t| t.gsub(/is_/, '').humanize }.join(' ') + ' Issue'
  end

  def event_status_icon(event)
    return 'secure-icon' if event.secure?
    return 'emergency-icon' if event.medical? || event.emergency?
    return 'sticky-icon' if event.sticky?
    return 'active-icon' if event.is_active?
  end

  def get_active_count
    Event.current_convention.num_active - Event.current_convention.num_active_secure
  end

  def get_secure_count
    return 0 unless current_user.rw_secure?

    Event.current_convention.num_active_secure
  end

  def active_link
    content_tag :div, id: 'unsticky_link' do
      [
        content_tag(:span, '', class: 'active-icon inactive-icon'),
        link_to('View Active', root_path)
      ].join.html_safe
    end
  end

  def active_text
    content_tag :div do
      [
        content_tag(:span, '', class: 'active-icon current-icon'),
        content_tag(:strong, 'Viewing Active')
      ].join.html_safe
    end
  end

  def secure_link
    if current_user.rw_secure?
      content_tag :div, id: 'secure_link' do
        [
          content_tag(:span, '', class: 'secure-icon inactive-icon'),
          link_to('View Active Secure', secure_events_path)
        ].join.html_safe
      end
    end
  end

  def secure_text
    content_tag :div do
      [
        content_tag(:span, '', class: 'secure-icon current-icon'),
        content_tag(:strong, 'Viewing Active Secure')
      ].join.html_safe
    end
  end

  def sticky_link
    content_tag :div, id: 'sticky_link' do
      [
        content_tag(:span, '', class: 'sticky-icon inactive-icon'),
        link_to('View Sticky', sticky_events_path)
      ].join.html_safe
    end
  end

  def sticky_text
    content_tag :div do
      [
        content_tag(:span, '', class: 'sticky-icon current-icon'),
        content_tag(:strong, 'Viewing Sticky')
      ].join.html_safe
    end
  end

  def sidebar_menu
    case url_for
    when root_path, events_path
      active_text <<
        secure_link <<
        sticky_link
    when sticky_events_path
      active_link <<
        secure_link <<
        sticky_text
    when secure_events_path
      active_link <<
        secure_text <<
        sticky_link
    else
      content_tag :div, 'I HAVE NO IDEA WHAT TO DO NOW!'
    end
  end

  def index_filter(key)
    [
      content_tag(:span, '', class: "filter-icon #{current_class(key)}"),
      link_to(key.to_s.titleize, sessions_set_index_filter_path(index_filter: { key => true }), method: :post,
                                                                                                class: active_index_filter?(key) ? 'current_index_filter' : nil)
    ].join.html_safe
  end

  def active_index_filter?(key)
    session[:index_filter]&.keys&.include?(key.to_s)
  end

  def current_class(key)
    return 'current-icon' if active_index_filter?(key)

    ''
  end

  def flag_display(flag)
    flag.gsub(/is_/, '').titleize.gsub(' ', '&nbsp;').html_safe
  end
end
