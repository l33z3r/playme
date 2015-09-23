class CreateSongsUsers < ActiveRecord::Migration
  def change
    create_table :songs_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :song, index: true
    end
  end
end
