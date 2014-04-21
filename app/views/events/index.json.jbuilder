json.array! @events do |e|
    json.id e.id
    json.entry e.entries.first.description
end
