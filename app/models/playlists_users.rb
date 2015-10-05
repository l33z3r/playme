class PlaylistsUsers < ActiveRecord::Base
  belongs_to :playlist, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :playlist, presence:true
  validates :user, presence:true
end
