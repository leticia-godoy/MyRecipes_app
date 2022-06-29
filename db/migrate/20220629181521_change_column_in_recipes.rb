class ChangeColumnInRecipes < ActiveRecord::Migration[7.0]
  def change
    rename_column :recipes, :chefs_id, :chef_id
  end
end
