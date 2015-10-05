class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.belongs_to :song, index: true, foreign_key: true
      t.string :title
      t.string :url
      t.string :type

      t.timestamps null: false
    end
  end
end
