class HomeController < ApplicationController
  def index

    if !@spotify_user.nil?
      @playlist = @spotify_user.playlists.select { |playlist| playlist.name == '<3' }.first

      if !@playlist
        @playlist = @spotify_user.playlists.first
      end

      @playlist.tracks.each do |track|

        artist = Artist.find_or_create_by name: track.artists.first.name

        song = Song.find_or_create_by spotify_track_id: track.id, spotify_url: track.uri, name: track.name, artist: artist

      end

    end

    @songs = Song.all


  end
end
