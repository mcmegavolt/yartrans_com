class Feedback

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :phone, :message, :email

  validates :phone, :presence => true
  validates :name, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end