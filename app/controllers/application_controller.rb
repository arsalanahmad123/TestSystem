class ApplicationController < ActionController::Base

    helper_method :current_user,:logged_in?,:login,:logout,:require_admin

    def current_user 
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        current_user != nil
    end

    def login(user)
        session[:user_id] = user.id 
    end

    def logout
        session[:user_id] = nil
    end

    def require_admin
        unless current_user && current_user.admin?
            flash[:error] = "You must be an admin to access this section"
            redirect_to root_path
        end
    end

    def require_user 
        unless logged_in?
            flash[:error] = "You must be logged in to access this section"
            redirect_to root_path
        end
    end

end
