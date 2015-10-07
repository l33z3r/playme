class AddAlbumArtworkUrlToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :album_artwork_url, :string
  end
end
