class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_device_link_key

  has_many :login_attempts

  def generate_device_link_key
    self.device_link_key = SecureRandom.hex

    #TODO: make sure it's unique
  end

  def qr_code_device_link_key
    RQRCode::QRCode.new(self.device_link_key).as_html.html_safe
  end

end
