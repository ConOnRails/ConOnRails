json.array!(@lost_and_found_categories) do |lost_and_found_category|
  json.extract! lost_and_found_category, :id, :name
  json.url lost_and_found_category_url(lost_and_found_category, format: :json)
end
