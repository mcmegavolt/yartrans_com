class Profile < ActiveRecord::Base
  
  attr_accessible :name, :personal_id, :phone_main, :phone_alternate, :alt_email

  belongs_to :user

end
