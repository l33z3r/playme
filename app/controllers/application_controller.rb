class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, :except => [:device_verify]

  before_action :authenticate_user!, except: [:login_attempt, :login, :device_verify]

end

