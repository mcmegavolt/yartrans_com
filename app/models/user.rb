class User < ActiveRecord::Base

  state_machine :initial => :free do
   
    event :owes_money do
      transition :free => :debtor
    end

    event :no_debt do
      transition :debtor => :free
    end

    state nil

  end

  before_validation :generate_password, :on => :create

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
                  :tariff_attributes,
                  :staffs_attributes,
                  :state

  attr_accessor :updated_by

  has_and_belongs_to_many :roles

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  has_one :tariff, :dependent => :destroy
  accepts_nested_attributes_for :tariff

  has_many :staffs, :dependent => :destroy
  accepts_nested_attributes_for :staffs, :reject_if => :all_blank, :allow_destroy => true

  has_many :admission_apps, :dependent => :destroy
  has_many :release_apps, :dependent => :destroy
  has_many :reports, :dependent => :destroy

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

  def generate_password
    o =  [('a'..'z'), ('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
    self.password = self.password_confirmation = (0..16).map{ o[rand(o.length)] }.join if self.password.blank?
  end

end