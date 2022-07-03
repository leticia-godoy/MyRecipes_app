require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefs_name: "Andre", email: "andre@gmail.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefs_name: "Paul", email: "paul@gmail.com",
                        password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefs_name: "Paul1", email: "paul1@gmail.com",
                        password: "password", password_confirmation: "password", admin: true)
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

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user,"password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefs_name: "Alex3", email: "chefalex3@mailinator.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Alex3", @chef.chefs_name
    assert_match "chefalex3@mailinator.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2,"password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: { chef: { chefs_name: updated_name, email: updated_email}}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Andre", @chef.chefs_name
    assert_match "andre@gmail.com", @chef.email
  end

end
