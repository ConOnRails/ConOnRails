# frozen_string_literal: true

json.array! @events do |e|
  json.id e.id
  json.created_at e.created_at.getlocal.ctime
  json.entries e.entries do |en|
    json.user do
      json.realname en.user.realname
      json.id en.user.id
    end
    json.created_at en.created_at.getlocal.ctime
    json.rolename en.rolename
    json.description en.description
  end
end
