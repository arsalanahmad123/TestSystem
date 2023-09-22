class PagesController < ApplicationController
  before_action :restrict_user, only: [:index]
  def index
    @user = User.new 
  end


end
