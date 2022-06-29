class AddChefIdToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :chefs_id, :integer 
  end
end
