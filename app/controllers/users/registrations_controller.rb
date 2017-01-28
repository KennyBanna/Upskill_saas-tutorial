class Users::RegistrationsController < Devise::RegistrationsController 
  before_action :select_plan, only: :new
  
  # Extend default devise gem behaviour so that users 
  # signing up with pro account (Plan ID: 2)
  # Save with a special function.
  # Otherwise Devise makes a normal save
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save    
        end
      end
    end
  end
  
  private 
    def select_plan
      unless(params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = 'Please select a plan to sign up with'
        redirect_to root_path
      end
    end
end