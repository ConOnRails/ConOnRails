def show_this(e)
  if e.entries.count == 1
    e.entries.first.description
  else
    "<div class='card-text'><div>UPDATE: #{e.entries.last.description}</div><hr><div>ORIG: #{e.entries.first.description}</div></div>"
  end
end

json.array! @events do |e|
  json.id e.id
  json.entry show_this e
end
