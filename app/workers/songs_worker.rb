class SongsWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform(song_id)
    song = Song.find(song_id)
    logger.info "working for song #{song.id}"

    #TODO: validate url and find out what site it belongs to for now we use ultimate guitar and assume valid

    mechanize = Mechanize.new
    mechanize.user_agent_alias = 'Mac Safari'
    mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    page = mechanize.get(song.url)

    chord_text = page.at('#cont > pre + pre').text.strip

    song.chord_text = chord_text
    song.save!
  end
end