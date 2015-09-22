class ModifySongs < ActiveRecord::Migration
  def change
    add_column :songs, :spotify_track_id, :string
    rename_column :songs, :url, :songsterr_url
    add_column :songs, :spotify_url, :string
  end
end
