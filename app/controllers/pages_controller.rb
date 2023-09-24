class PagesController < ApplicationController 
  def index ;end

  def not_found 
    render status: 404
  end 


end
