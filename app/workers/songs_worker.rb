class SongsWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform(song_id)
    song = Song.find(song_id)
    logger.info "working for song #{song.id}"
  end
end