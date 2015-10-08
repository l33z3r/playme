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

require 'test_helper'

class SongTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
