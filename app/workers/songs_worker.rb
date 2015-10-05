class SongsWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform(song_id, user_id)
    song = Song.find(song_id)
    user = User.find(user_id)
    logger.info "working for song #{song.id}"

    songsterr_song = Songsterr::Song.where(:pattern => "#{song.name} #{song.artist.name}")

    if songsterr_song.first
       Material.find_or_create_by url: "http://www.songsterr.com/a/wa/song?id=#{songsterr_song.first.id}",
                                 song: song, title: "Songsterr Link for #{song.name}", user: user
    end
  end
end