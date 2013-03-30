class ReleaseApp < ActiveRecord::Base

  attr_accessible :release_date,
                  :release_time,
                  :recipient,
                  :vehicle,
                  :notes, 
  								:user_id,
                  :release_items_attributes


  belongs_to :user
  
  has_many :release_items, :dependent => :destroy
  accepts_nested_attributes_for :release_items, :reject_if => :all_blank, :allow_destroy => true

  validates_presence_of :release_date, :recipient, :vehicle

  default_scope order('created_at DESC')   

end
