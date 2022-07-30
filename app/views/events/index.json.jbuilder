# frozen_string_literal: true

json.array! @events do |e|
  json.id e.id
  json.created_at e.created_at
  json.updated_at e.updated_at
  json.entries e.entries, :id, :description
end
