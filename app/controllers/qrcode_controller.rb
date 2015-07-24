class QrcodeController < ApplicationController
  def login_attempt
    @la_key = SecureRandom.hex
    la = LoginAttempt.new(login_key: @la_key)

    #TODO: make sure unique loginattempt
    #also delete some old login attempts

    la.save!

    @qr_code = RQRCode::QRCode.new(@la_key)

  end

  def login
    login_key = params[:login_key]

    la = LoginAttempt.where(login_key: login_key).take!

    if !la.user.nil?
      #do login
      sign_in(User, la.user)
      render json: '', status: :ok
    else
      render json: '', status: :unauthorized
    end
  end

  def device_verify
    user_key = params[:user_key]
    login_key = params[:login_key]

    la = LoginAttempt.where(login_key: login_key).take!

    #mark this login attempt as successful by attaching the user_id
    user = User.where(device_link_key: user_key).take!

    user.login_attempts.destroy_all

    la.user = user
    la.save
  end
end
