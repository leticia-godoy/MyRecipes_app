require "test_helper"

class RecipesEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = Chef.create!(chefs_name: "Andre", email: "andre@gmail.com")
    @recipe = Recipe.create(name: "Cheese Cauliflower",description: "It smells great!",sell_price: 300, chef: @user)

  end

  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ",description: "example", sell_price: 100 }}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'   
  end

  test "successfully edit a recipe" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipes name"
    updated_description = "updated recipe description"
    updated_sell_price = 00
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description, sell_price: updated_sell_price}}
    assert_redirected_to @recipe
    #follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
    assert_match updated_sell_price, @recipe.sell_price
  end
end
