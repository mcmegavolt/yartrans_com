class Article::SubSection < ActiveRecord::Base
  
  attr_accessible :title, :sub_section_items_attributes
  belongs_to :sub_sectionable, :polymorphic => true

  has_many :sub_section_items, :dependent => :destroy
  accepts_nested_attributes_for :sub_section_items, :reject_if => :all_blank, :allow_destroy => true

  validates_presence_of :title

end
