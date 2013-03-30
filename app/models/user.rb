class User < ActiveRecord::Base

  # :token_authenticatable
  # :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :lockable, :registerable, :confirmable

  include Mailboxer::Models::Messageable
  acts_as_messageable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me, 
                  :role_ids, 
                  :profile_attributes,
                  :admission_app_attributes,
                  :release_app_attributes,
                  :tariff_attributes

  attr_accessor :updated_by

  has_and_belongs_to_many :roles

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  has_one :tariff, :dependent => :destroy
  accepts_nested_attributes_for :tariff

  has_many :admission_apps, :dependent => :destroy
  has_many :release_apps, :dependent => :destroy

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
	end

  def role
    self.roles.last.name
  end

  def to_s
    self.profile.name
  end

  def name
    email
  end

  def mailboxer_email(object)
    email
  end

end