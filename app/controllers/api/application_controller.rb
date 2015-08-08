module Api
  class ApplicationController < ActionController::Base
    before_action :authenticate_api_user

    def authenticate_api_user
      if params[:device_link_key]!=nil

        user = User.where({device_link_key: params[:device_link_key]}).first

        sign_in(User, user)
      else
        render json: '', status: :unauthorized
      end
    end

  end
end
