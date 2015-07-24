class AddDeviceLinkKey < ActiveRecord::Migration
  def change
    add_column :users, :device_link_key, :string
  end
end
