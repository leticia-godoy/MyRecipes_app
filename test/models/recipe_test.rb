require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

    def setup
        @recipe = Recipe.new(name: "Fried Egg", description: "Sunny-side up", sell_price: 35)
    end

    test "recipe should be valid" do
        assert @recipe.valid?
    end

    # validate recipes name
    test "name should be present" do
        @recipe.name = ""
        assert_not @recipe.valid?
    end

    # validate recipes description
    test "Description should be present" do
        @recipe.description = ""
        assert_not @recipe.valid?
    end

    test "description shouldn't be less than 5 characters" do
        @recipe.description = "a" * 3
        assert_not @recipe.valid?
    end
    
    # validate recipes sell_price
    test "sell_price should be present" do
        @recipe.sell_price = nil
        assert_not @recipe.valid?
    end
end