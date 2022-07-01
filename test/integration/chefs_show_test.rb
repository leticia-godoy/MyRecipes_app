require "test_helper"

class ChefsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = Chef.create!(chefs_name: "Andre", email: "andre@gmail.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Cheese Cauliflower",description: "It smells great!",sell_price: 300, chef: @user)
    @recipe2 = Recipe.recipes.build(name: "Baked Fish",description: "Baked fish on a bed of herbs",sell_price: 100)
    @recipe2.save
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefsname, response.body
  end
end
