class ApplicationController < ActionController::Base

    helper_method :current_user,:logged_in?,:login,:logout,:require_admin,:require_approved_user,:restrict_user,:require_user

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        current_user != nil
    end

    def login(user)
        session[:user_id] = user.id 
        @current_user = user
    end

    def logout
        session[:user_id] = nil
        @current_user = nil # Clear the cached user object
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

    def require_approved_user 
        unless current_user && current_user.allowed? || current_user.admin? 
            flash[:error] = "Currently you are not approved kindly contact the administration"
            redirect_to request.referrer || root_path
        end
    end

    def restrict_user 
        if current_user 
            redirect_to papers_path
        end
    end

end
