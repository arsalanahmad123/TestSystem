class UsersController < ApplicationController
    before_action :require_admin, only: [:new, :create]
    def new 

    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            flash[:success] = "Welcome to the Quiz #{@user.username}!"
            redirect_to root_path
        else 
            flash.now[:error] ="#{@user.errors.full_messages.join(', ')}"
            redirect_to root_path
        end
    end


    private 

        def user_params 
            params.require(:user).permit(:email, :password, :password_confirmation,:username)
        end
end
