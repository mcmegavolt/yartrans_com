class User < ActiveRecord::Base

  # :token_authenticatable
  # :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :lockable, :registerable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids, :profile_attributes

  attr_accessor :updated_by

  has_and_belongs_to_many :roles

  has_one :profile, :dependent => :destroy

  accepts_nested_attributes_for :profile

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
	end

  def role
    self.roles.last.name
  end

end
