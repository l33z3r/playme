class PlaylistsSongs < ActiveRecord::Base
  belongs_to :playlist, dependent: :destroy
  belongs_to :song, dependent: :destroy

  validates :playlist, presence:true
  validates :song, presence:true
end
