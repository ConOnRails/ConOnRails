def show_this(e)
  if e.entries.count == 1
    e.entries.first.description
  else
    "UPDATE: #{e.entries.last.description}\n--------\nORIG: #{e.entries.first.description}"
  end
end

json.array! @events do |e|
    json.id e.id
    json.entry show_this e
end
