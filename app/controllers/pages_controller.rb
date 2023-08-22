class PagesController < ApplicationController
  before_action :redirect_user, only: [:index]
  def index
    @user = User.new 
    if current_user && !current_user.admin?
      redirect_to papers_path, alert: "You are already logged in"
    end
  end


  private

    def redirect_user
      if current_user && !current_user.admin?
        redirect_to papers_path, alert: "You are already logged in"
      end
    end

end
