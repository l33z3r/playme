class HomeController < ApplicationController
  def index
    # list out playlists
    @playlists = []

    if !@spotify_user.nil?
      @playlists = @spotify_user.playlists
    end

  end
end
