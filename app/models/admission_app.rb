class AdmissionApp < ActiveRecord::Base
  
  attr_accessible :notes, 
  								:user_id, 
  								:vehicle,
                  :admission_date,
                  :admission_time,
                  :file,
                  :remove_file,
                  :admission_items_attributes

  belongs_to :user

  has_many :admission_items, :dependent => :destroy
  accepts_nested_attributes_for :admission_items, :reject_if => :all_blank, :allow_destroy => true

  mount_uploader :file, AdmissionFileUploader

  # validates_presence_of :vehicle, :admission_date

  default_scope order('created_at DESC') 

end
