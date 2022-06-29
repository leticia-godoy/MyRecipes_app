require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = Chef.create!(chefs_name: "Andre", email: "andre@gmail.com")
    @recipe = Recipe.create(name: "Cheese Cauliflower",description: "It smells great!",sell_price: 300, chef: @user)
    @recipe2 = Recipe.recipes.build(name: "Baked Fish",description: "Baked fish on a bed of herbs",sell_price: 100)
    @recipe2.save
  end
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end

end
