module LostAndFoundItemsHelper
  def checkbox( tag, label )
    out = check_box_tag tag
    out += label_tag tag, "#{label}"
  end
end
