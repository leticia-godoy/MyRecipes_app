class IngredientsController < ApplicationController

    before_action :set_ingredient, only: [:edit, :update, :show]
    before_action :require_admin, except: [:show, :index]
    INGREDIENTS_PAGE = 5
    
    def new
        @ingredient = Ingredient.new
    end

    def create 
        @ingredient = Ingredient.new(ingredient_params)
        if @ingredient.save
            flash[:success] = "Ingredient was successfully created!"
            redirect_to ingredient_path(@ingredient)
        else
            render 'new'
        end
    end

    def edit 
    
    end

    def update 
        if @ingredient.update(ingredient_params)
            flash[:successs] = "Ingredient was successfully updated!"
            redirect_to ingredient_path(@ingredient)
        else
            render 'edit'
        end
    end

    def show 
        @page = params.fetch(:page, 0).to_i
        @ingredients = Ingredient.offset(@page * INGREDIENTS_PAGE).limit(INGREDIENTS_PAGE) 
    end

    def index
        @page = params.fetch(:page, 0).to_i
        @ingredients = Ingredient.offset(@page * INGREDIENTS_PAGE).limit(INGREDIENTS_PAGE)    
    end
    
    private
    def require_admin
        if !logged_in? || (logged_in? and !current_chef.admin?)
            flash[:danger] = "Only admin users can perform that action"
            redirect_to ingredient_path
        end
    end

    def ingredient_params
        params.require(:ingredient).permit(:name)
    end

    def set_ingredient
        @ingredient = Ingredient.find(params[:id])
    end
end