module LostAndFoundItemsHelper
  def checkbox(tag, label, checked = false)
    check_box_tag(tag, '1', checked) + label_tag(tag, "#{label}")
  end
end
