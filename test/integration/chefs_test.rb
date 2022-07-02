require "test_helper"

class ChefsTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef1 = Chef.create!(chefs_name: "Andre", email: "andre@gmail.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefs_name: "Paul", email: "paul@gmail.com",
                        password: "password", password_confirmation: "password")
  end
  
  test "should get chefs index" do
    get chefs_path
    assert_response :success
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef1), text: @chef1.chefs_name.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefs_name.capitalize
  end

end
