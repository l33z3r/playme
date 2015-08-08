json.array!(@songs) do |song|
  json.extract! song, :id, :name, :url, :genre_id, :difficulty, :artist_id
  json.url song_url(song, format: :json)
end
