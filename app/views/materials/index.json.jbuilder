json.array!(@materials) do |material|
  json.extract! material, :id, :song_id, :title, :url, :type
  json.url material_url(material, format: :json)
end
