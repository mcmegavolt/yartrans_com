class Article::SubSectionItem < ActiveRecord::Base
  attr_accessible :body, :caption, :entry, :photo, :title, :sub_section_id

  belongs_to :sub_section, :class_name => Article::SubSection

  validates_presence_of :entry, :body

  validates_presence_of :title#, :unless => :caption?
  validates_presence_of :caption

  mount_uploader :photo, SubSectionItemPhotoUploader

  default_scope order('created_at DESC')

end
