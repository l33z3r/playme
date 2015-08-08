json.array!(@songs) do |song|
  json.extract! song, :id, :name, :url, :genre_id, :difficulty
  json.artist song.artist
  json.url api_song_url(song, format: :json)
end
