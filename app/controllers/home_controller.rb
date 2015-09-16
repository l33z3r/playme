class HomeController < ApplicationController
  def index
    # list out playlists
    @playlists = @spotify_user.playlists
  end
end
