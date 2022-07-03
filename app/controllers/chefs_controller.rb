class ChefsController < ApplicationController

    before_action :set_chef, only: [:show, :edit, :update, :delete]
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
            session[:chef_id] = @chef.id
            flash[:success] = "Welcome, chef  #{@chef.chefs_name} to MyRecipes App!"
            redirect_to chef_path(@chef)
        else
            render 'new'
        end
    end

    def show
    end

    def edit
    end

    def update
        if @chef.update(chef_params)
            flash[:success] = "Account updated successfully!"
            redirect_to @chef
        else
            render 'edit'
        end
    end

    def destroy 
        @chef.destroy
        flash[:danger] = "Chef and all associated recipes have been deleted!"
        redirect_to chefs_path
    end

    private 

        def chef_params
            params.require(:chef).permit(:chefs_name, :email, :password, :password_confirmation)
        end

        def set_chef
            @chef = Chef.find(params[:id])
        end
end