module LostAndFoundItemsHelper
  def checkbox( tag, label, checked=false )
    out = check_box_tag tag, '1', checked
    out += label_tag tag, "#{label}"
  end
end
