class Contact < ActiveRecord::Base
  #Form validation
  validates :name, presence: true
  validates :email, presence: true
  validates :comments, length: { within: 5..180 }, presence: true
end