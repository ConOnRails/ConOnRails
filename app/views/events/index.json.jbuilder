# frozen_string_literal: true

def show_this(evt)
  if evt.entries.count == 1
    evt.entries.first.description
  else
    "<div class='card-text'><div>UPDATE: #{evt.entries.last.description}</div>
     <hr><div>ORIG: #{evt.entries.first.description}</div></div>"
  end
end

json.array! @events do |evt|
  json.id evt.id
  json.entry show_this evt
end
