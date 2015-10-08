# == Schema Information
#
# Table name: playlists
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  spotify_id :string
#

class Playlist < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :songs
end
