class CreateSongs < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :artists do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :songs do |t|
      t.string :name
      t.string :url
      t.references :genre, index: true, foreign_key: true
      t.integer :difficulty
      t.references :artist, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
