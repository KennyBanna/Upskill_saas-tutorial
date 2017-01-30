class ProfilesController < ApplicationController
  #GET request to users/:user_id/profile/new
  def new
    @profile = Profile.new
    #Render profile details form 
  end
end