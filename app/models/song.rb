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
  validates :spotify_track_id, uniqueness: true


  def youtube_material

    Yt.configure do |config|
      config.api_key = 'AIzaSyDaFZsrBWmKjSuxmb_8F6gW-A9Za3F38nA'
    end

    videos = Yt::Collections::Videos.new(max_results: 10)
    videos.where(q: "Guitar tutorial #{name} #{artist.name}", order: 'viewCount', safe_search: 'none')


    # api_key = 'AIzaSyDaFZsrBWmKjSuxmb_8F6gW-A9Za3F38nA'
    # client = YouTubeIt::Client.new(:dev_key => api_key)
    # client.videos_by(:query => "Guitar tutorial #{self.name} #{self.artist.name}", :per_page => 15)
  end
end
