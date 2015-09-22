# == Schema Information
#
# Table name: songs_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  song_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SongsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :user, presence:true
  validates :song, presence:true
end
