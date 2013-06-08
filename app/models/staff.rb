class Staff < ActiveRecord::Base
  belongs_to :user
  attr_accessible :email, :name
end
