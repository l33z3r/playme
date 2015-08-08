# == Schema Information
#
# Table name: login_attempts
#
#  id         :integer          not null, primary key
#  login_key  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LoginAttempt < ActiveRecord::Base
  belongs_to :user
end
