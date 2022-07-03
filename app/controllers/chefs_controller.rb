class ChefsController < ApplicationController

    RECIPES_PAGE = 5
    
    def index
        @page = params.fetch(:page, 0).to_i
        @chefs = Chef.offset(@page * RECIPES_PAGE).limit(RECIPES_PAGE)
    end


    def new
        @chef = Chef.new
    end

    def create 
        @chef = Chef.new(chef_params)
        if @chef.save
            flash[:success] = "Welcome, chef  #{@chef.chefs_name} to MyRecipes App!"
            redirect_to chef_path(@chef)
        else
            render 'new'
        end
    end

    def show
        @chef = Chef.find(params[:id])
    end

    def edit
        @chef = Chef.find(params[:id])
    end

    def update
        @chef = Chef.find(params[:id])
        if @chef.update(chef_params)
            flash[:success] = "Account updated successfully!"
            redirect_to @chef
        else
            render 'edit'
        end
    end

    private 

        def chef_params
            params.require(:chef).permit(:chefs_name, :email, :password, :password_confirmation)
        end
end