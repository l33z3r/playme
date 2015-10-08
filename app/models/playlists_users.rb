# == Schema Information
#
# Table name: playlists_users
#
#  id          :integer          not null, primary key
#  playlist_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PlaylistsUsers < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user

  validates :playlist, presence:true
  validates :user, presence:true
end
