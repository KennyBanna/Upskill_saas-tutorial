class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\z/
  
  validates :phone_number, length: {maximum: 15},
                          format: { with: /\A(\d{2,3}-?)(\d{2,3}-?)(\d{2,4})\z/}
end