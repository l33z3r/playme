class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, :except => [:device_verify]

  before_action :authenticate_user!, except: [:login_attempt, :login, :device_verify]
  before_action :setup_spotify_user

  private

  def setup_spotify_user
    if current_user and current_user.spotify_info_hash
      @spotify_user = RSpotify::User.new(current_user.spotify_info_hash)
    end
  end
end

