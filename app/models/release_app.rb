class ReleaseApp < ActiveRecord::Base

  state_machine :state, :initial => :pending do
    event :process_app do
      transition [:pending, :stoped] => :processing
    end

    event :complete_app do
      transition :processing => :completed
    end

    event :stop_app do
      transition [:pending, :processing] => :stoped
    end
  end

  attr_accessible :release_date,
                  :release_time,
                  :recipient,
                  :vehicle,
                  :notes, 
  								:user_id,
                  :file,
                  :remove_file,
                  :release_items_attributes,
                  :staff_id

  belongs_to :user
  belongs_to :staff
  
  has_many :release_items, :dependent => :destroy
  accepts_nested_attributes_for :release_items, :reject_if => :all_blank, :allow_destroy => true

  mount_uploader :file, ReleaseFileUploader

  # validates_presence_of :recipient, :vehicle

  default_scope order('created_at DESC')   

end
