class AddChordTextToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :chord_text, :text
  end
end
