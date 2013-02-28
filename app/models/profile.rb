class Profile < ActiveRecord::Base
  
  attr_accessible :name, :personal_id, :phone_main, :phone_alternate

  belongs_to :user

end
