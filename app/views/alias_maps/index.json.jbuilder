json.array!(@alias_maps) do |alias_map|
  json.extract! alias_map, :id
  json.url alias_map_url(alias_map, format: :json)
end
