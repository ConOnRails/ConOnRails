module EventsHelper
  def create_or_update
    (@event.new_record? ? 'Create a new ' : 'Update a') + ' log entry'
  end

  def filter(term)
    params[:filters][term].presence if params[:filters].present?
  end

  def merge_button
    link_to merge_mode_toggle_text,
            merge_button_path,
            remote: true,
            class: "button merge-button #{merge_toggle_class}"
  end

  def merge_button_path
    new_params = toggle_merge_mode(params.clone)

    case params[:action].to_sym
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
            class: 'button submit-button',
            onclick: 'document.getElementById("merge-form").submit()'
  end

  def merge_mode_toggle_text
    return 'Cancel Merge' if params[:merge_mode] == 'true'
    'Merge Events'
  end

  def toggle_merge_mode(new_params)
    new_params[:merge_mode] = new_params[:merge_mode] == 'true' ? 'false' : 'true'
    new_params
  end

  def merge_toggle_class
    'cancel-merge' if params[:merge_mode] == 'true'
  end

  def event_style(event)
    ret = ''
    ret << 'active ' if event.is_active?
    ret << 'medical ' if event.medical?
    ret << 'emergency ' if event.emergency?
    ret << 'sticky ' if event.sticky?
    ret
  end

  def event_tags(event)
    ret = ''
    ret << 'Active ' if event.is_active?
    ret << 'Medical ' if event.medical?
    ret << 'Emergency ' if event.emergency?
    ret << 'Sticky ' if event.sticky?
    ret + 'Issue'
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
      link_to 'View Active', root_path
    end
  end

  def active_text
    content_tag :div do
      content_tag :strong, 'Viewing Active'
    end
  end

  def secure_link
    if current_user.rw_secure?
      content_tag :div, id: 'secure_link' do
        link_to 'View Active Secure', secure_events_path
      end
    end
  end

  def secure_text
    content_tag :div do
      content_tag :strong, 'Viewing Active Secure'
    end
  end

  def sticky_link
    content_tag :div, id: 'sticky_link' do
      link_to 'View Sticky', sticky_events_path
    end
  end

  def sticky_text
    content_tag :div do
      content_tag :strong, 'Viewing Sticky'
    end
  end

  def sidebar_menu
    case url_for()
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
        sticky_text <<
        sticky_link
      else
        content_tag :div, "I HAVE NO IDEA WHAT TO DO NOW!"
    end
  end
end
