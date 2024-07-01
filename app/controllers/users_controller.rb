class UsersController < ApplicationController
    before_action :require_admin,only: [:verify_user,:database,:destroy,:resetuserpaper]
    before_action :restrict_user,only: [:new,:create]
    before_action :require_user,only: [:profile,:edit,:update]
    def new 
        @user = User.new
    end

    def index 
        @users = User.all 
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


    def resetuserpaper 
        user = User.find(params[:id])
        if !user.attempted_papers.empty?
            user.attempted_papers.each do |attempted_paper|
                attempted_paper.destroy
            end
            redirect_to users_path, notice: "User Paper Reset Successful"
        else
            redirect_to users_path, notice: "User's Attempted Papers are Empty"
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

    def edit 
        @user = current_user if current_user
    end 

    def update 
        @user = current_user
        @user.update(user_params)
        redirect_to profile_path, notice: "Profile was successfully updated."
    end

    def profile 
        @user = current_user
        @scores = @user.scores 
        @papers = []
        @scores.each do |score|
            @papers << score.paper
        end
    end


    def database 
        @papers = Paper.all
        @users = User.includes(scores: :paper).all
    end

    def destroy 
        @user = User.find(params[:id])
        if @user.destroy 
            respond_to do |format|
                format.turbo_stream{
                    render turbo_stream: turbo_stream.remove("user-#{@user.id}")
                }
            end
        else
            redirect_to users_path, notice: "Something went wrong"
        end
    end


    private 

        def user_params 
            params.require(:user).permit(:email, :password, :password_confirmation,:username)
        end
end
