class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # If coming from a devise signup form, White list
  # the following form_fields so that we can process them. (Security feature)
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected 
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation) }
    end
end
