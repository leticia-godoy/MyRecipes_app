require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefs_name: "Andre", email: "andre@gmail.com",
                        password: "password", password_confirmation: "password")
  end

  test "reject invalid edit" do
    sign_in_as(@chef,"password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefs_name: " ", email: "chefalex@mailinator.com"}}
    #errors showing up, so it returns to the page
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid edit" do
    sign_in_as(@chef,"password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefs_name: "Alex", email: "chefalex@mailinator.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Alex", @chef.chefs_name
    assert_match "chefalex@mailinator.com", @chef.email
  end
end
