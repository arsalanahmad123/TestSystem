class UsersController < ApplicationController
    before_action :require_admin,only: [:verify_user]
    before_action :restrict_user,only: [:new,:create]
    before_action :require_user,only: [:profile]
    def new 
        @user = User.new
    end

    def index 
        @users = User.all_except(current_user)
    end

    def verify_user 
        user = User.find(params[:id])
        if user.allowed? 
            user.update(allowed: false)
            respond_to do |format|
                format.turbo_stream{
                    render turbo_stream: turbo_stream.replace("user-#{user.id}", partial: "users/user", locals: {user: user})
                }
            end
        else
            user.update(allowed: true)
            respond_to do |format|
                format.turbo_stream{
                    render turbo_stream: turbo_stream.replace("user-#{user.id}", partial: "users/user", locals: {user: user})
                }
            end
        end 
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            login(@user)
            redirect_to papers_path
            flash[:success] = "Welcome #{@user.username}!"
        else 
            redirect_to new_user_path
            flash[:error] ="#{@user.errors.full_messages.join(', ')}"
        end
    end

    def profile 
        @user = current_user
        @scores = @user.scores 
        @papers = []
        @scores.each do |score|
            @papers << score.paper
        end
    end


    private 

        def user_params 
            params.require(:user).permit(:email, :password, :password_confirmation,:username)
        end
end
