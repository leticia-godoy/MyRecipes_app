require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = Chef.create!(chefs_name: "Andre", email: "andre@gmail.com",
                        password: "password", password_confirmation: "password")
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
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes to show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @recipe.sell_price, response.body
    assert_match @chef.chefs_name, response.body
    assert_select "a[href=?]", edit_recipe_path(@recipe), text: "edit recipe"
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete recipe"
    assert_select "a[href=?]", recipe_path, text: "return to recipes list"
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "Complete breakfast"
    description_of_recipe = "You'll feel ready to take on the world!"
    sell_price_of_recipe = 350
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: {name: name_of_recipe, description: description_of_recipe, sell_price: sell_price_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
    assert_match sell_price_of_recipe, response.body
  end

  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name: " ", description: " " } }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
