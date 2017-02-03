class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
  end  
  
  #Get request to '/users/:id'
  def show
    @user = User.find(params[:id])
  end
end