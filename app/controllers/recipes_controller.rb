class RecipesController < ApplicationController

    
    before_action :set_recipe, only: [:show, :edit, :update]
    RECIPES_PAGE = 5
    
    def index
        @page = params.fetch(:page, 0).to_i
        @recipes = Recipe.offset(@page * RECIPES_PAGE).limit(RECIPES_PAGE)
    end

    def show
        
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = current_chef
        if @recipe.save
            flash[:success] = "Recipe was created successfully!"
            redirect_to recipe_path(@recipe)
        else 
            render 'new'
        end
    end

    def edit
        
    end
    def update
        
        if @recipe.update(recipe_params)
            flash[:success] = "Recipe was updated successfully!"
            redirect_to recipe_path(@recipe)
        else
            render 'edit'
        end
    end

    def destroy
        Recipe.find(params[:id]).destroy        
        flash[:success] = "Recipe deleted successfully!"
        redirect_to recipes_path
    end 

    private

        def set_recipe 
            @recipe = Recipe.find(params[:id])
        end

        def recipe_params
            params.require(:recipe).permit(:name, :sell_price, :description)
        end

end