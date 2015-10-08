# == Schema Information
#
# Table name: songs
#
#  id                :integer          not null, primary key
#  name              :string
#  songsterr_url     :string
#  genre_id          :integer
#  difficulty        :integer
#  artist_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  chord_text        :text
#  spotify_track_id  :string
#  spotify_url       :string
#  album_artwork_url :string
#

class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  has_and_belongs_to_many :playlists
  has_many :materials, dependent: :destroy

  validates :artist, presence: true
end
