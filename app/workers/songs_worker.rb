class SongsWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform(song_id)
    song = Song.find(song_id)
    logger.info "working for song #{song.id}"

    songsterr_song = Songsterr::Song.where(:pattern => "#{song.name} #{song.artist.name}")

    if !songsterr_song.first.nil?
      song.songsterr_url = "http://www.songsterr.com/a/wa/song?id=#{songsterr_song.first.id}"
      song.save!
    end
  end
end