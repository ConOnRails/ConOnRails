module EventsHelper
  def filter(term)
    params[:filters][term].presence if params[:filters].present?
  end

  def merge_button
    link_to merge_mode_toggle_text,
            events_path(toggle_merge_mode),
            remote: true,
            class:  "button merge-button #{merge_toggle_class}"
  end

  def merge_submit
    return nil if params[:merge_mode] != 'true'
    #submit_tag 'Merge',
    #           class: 'button merge-button'
    link_to 'Merge',
            '#',
            class: 'button submit-button',
            onclick: 'document.getElementById("merge-form").submit()'
  end

  def merge_mode_toggle_text
    return 'Cancel Merge Mode' if params[:merge_mode] == 'true'
    'Merge Mode'
  end

  def toggle_merge_mode
    { merge_mode: (params[:merge_mode] == 'true') ? false : true }
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
end
