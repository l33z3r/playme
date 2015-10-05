class RemoveTypeFromMaterials < ActiveRecord::Migration
  def change
    remove_column :materials, :type
  end
end
