class SessionsController < ApplicationController
    def new 

    end

    def create 
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            login(user)
            flash[:success] = "Welcome back! #{user.username}"
            redirect_to papers_path
        else
            flash[:error] = "Invalid email/password combination"
            redirect_to root_path
        end
    end

    def destroy 
        logout
         flash[:success] = "Goodbye! See you next time"
        redirect_to root_path
    end
end
