namespace :housekeeping do
  desc "delete all songs, playlists and material"
  task clear_songs_playlists: :environment do
    puts "deleting #{Material.count} materials"
    Material.destroy_all

    puts "deleting #{Song.count} songs"
    Song.destroy_all

    puts "deleting #{Playlist.count} playlists"
    Playlist.destroy_all

    puts "done"
  end

end
