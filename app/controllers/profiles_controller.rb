class ProfilesController < ApplicationController
  #GET request to users/:user_id/profile/new
  before_action :authenticate_user!
  before_action :only_current_user
  
  def new
    @profile = Profile.new
    #Render profile details form 
  end
  
  #POST request to user/:user_id/profile/new
  def create
    #Ensure that we have the user currently filling out form
    @user = User.find( params[:user_id])
    #Create profile linked to specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = 'Profile updated!' 
      redirect_to user_path(id: params[:user_id] )
    else
      flash[:warning] =  @profile.errors.full_messages.join(", ")
      render action :new
    end
  end 
  
  #GET request to /users/:user_id/profile/edit
  def edit 
    #Get current user
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  #PATCH or PUT request to /users/:user_id/profile
  def update
    #Retrieve user from database
    @user = User.find( params[:user_id] )
    #Retrieve users profile
    @profile = @user.profile 
    # Mass assign edited attributes and save (Update)
    if @profile.update_attributes( profile_params )
      flash[:success] = "Successfully updated profile"
      #Redirect to users profile page
      redirect_to user_path(id: params[:user_id])
    else
      render action :edit
    end
  end
  
  private
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_path) unless @user == current_user
    end
    
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
end