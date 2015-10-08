# == Schema Information
#
# Table name: playlists_songs
#
#  id          :integer          not null, primary key
#  playlist_id :integer
#  song_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PlaylistsSongs < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  validates :playlist, presence:true
  validates :song, presence:true
end
