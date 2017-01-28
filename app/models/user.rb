class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :plan
  attr_accessor :stripe_card_token
  
  def save_with_subscription
    # If pro Users passes validation (email, password, etc.)
    # Call Stripe to set up a subscription
    # Upon charging the customer's card
    # Stripe responds with customer data.
    # Store customer.id as customer token and save the user
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end
