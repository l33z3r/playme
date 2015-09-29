class HomeController < ApplicationController
  def index
    if @spotify_user
      redirect_to songs_url and return
    end

  end
end
