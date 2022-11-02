class SessionsController < ApplicationController

    def new

    end

    def create
        chef = Chef.find_by(email: params[:session][:email].downcase)
        if chef && chef.authenticate(params[:session][:password])
            session[:chef_id] = chef.id
            cookies.signed[:chef_id] = chef.id
            flash[:success] = "You have successfully logged in!"
            redirect_to chef
        else
            flash[:danger] = "there is something wrong with your login information"
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        session[:chef_id] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end

end