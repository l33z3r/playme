namespace :housekeeping do
  desc "delete all songs, playlists and material"
  task clear_songs_playlists: :environment do
    puts "deleting #{Song.count} songs"
    Song.destroy_all

    puts "deleting #{Playlist.count} playlists"
    Playlist.destroy_all

    puts "done"
  end

  desc "delete all data"
  task clear_all_data: :environment do
    puts "deleting #{User.count} users"
    User.destroy_all

    puts "deleting #{Song.count} songs"
    Song.destroy_all

    puts "deleting #{Playlist.count} playlists"
    Playlist.destroy_all

    puts "deleting #{LoginAttempt.count} login attempts"
    LoginAttempt.destroy_all

    puts "deleting #{Genre.count} genres"
    Genre.destroy_all

    puts "deleting #{Artist.count} artists"
    Artist.destroy_all

    puts "Done"
  end
end
