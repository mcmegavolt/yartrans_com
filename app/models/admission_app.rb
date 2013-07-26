class AdmissionApp < ActiveRecord::Base

  state_machine :state, :initial => :pending do
    event :process do
      transition [:pending, :stoped] => :processing
    end

    event :complete do
      transition :processing => :completed
    end

    event :stop do
      transition [:pending, :processing] => :stoped
    end
  end
  
  attr_accessible :notes, 
  								:user_id, 
  								:vehicle,
                  :admission_date,
                  :admission_time,
                  :file,
                  :remove_file,
                  :admission_items_attributes,
                  :staff_id

  belongs_to :user
  belongs_to :staff

  has_many :admission_items, :dependent => :destroy
  accepts_nested_attributes_for :admission_items, :reject_if => :all_blank, :allow_destroy => true

  mount_uploader :file, AdmissionFileUploader

  # validates_presence_of :vehicle, :admission_date

  default_scope order('created_at DESC') 

end
