class CreatePlaylistsUsers < ActiveRecord::Migration
  def change
    create_table :playlists_users do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
