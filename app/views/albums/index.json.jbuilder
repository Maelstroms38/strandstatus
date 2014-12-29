json.array!(@albums) do |album|
  json.extract! album, :id, :user, :references, :title
  json.url album_url(album, format: :json)
end
