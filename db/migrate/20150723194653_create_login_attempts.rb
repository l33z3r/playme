class CreateLoginAttempts < ActiveRecord::Migration
  def change
    create_table :login_attempts do |t|
      t.string :login_key
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
