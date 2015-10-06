class PlaylistsUsers < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user

  validates :playlist, presence:true
  validates :user, presence:true
end
