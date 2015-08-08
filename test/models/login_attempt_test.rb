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

require 'test_helper'

class LoginAttemptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
