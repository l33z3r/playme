class AddSpotifyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :spotify_info_hash, :text
  end
end
