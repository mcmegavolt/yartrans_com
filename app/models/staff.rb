class Staff < ActiveRecord::Base
 
  belongs_to :user

  has_many :admission_apps
	accepts_nested_attributes_for :admission_apps
	
  has_many :release_apps
	accepts_nested_attributes_for :release_apps

  attr_accessible :email, :name

end
