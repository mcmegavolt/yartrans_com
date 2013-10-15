class Article::Category < ActiveRecord::Base

  attr_accessible :name,
                  :description, 
                  :ancestry, 
                  :position, 
                  :permalink, 
                  :parent_id,
                  :is_featured,
                  :icon, :icon_cache, :remove_icon,
                  :meta_attributes

  has_ancestry

  has_many :pages, :class_name => Article::Page, :dependent => :destroy

  has_one :meta, :as => :metaable, :class_name => Article::Meta, :dependent => :destroy
  accepts_nested_attributes_for :meta, :reject_if => proc { |attr| attr[:title].blank? && attr[:description].blank? && attr[:keywords].blank? }

  before_save :generate_adv_cat_permalink
  
  validates_uniqueness_of :permalink

  default_scope order('position ASC')

  mount_uploader :icon, CategoryIconUploader

  scope :featured, where(:is_featured => true)

  def to_param
    permalink
  end

  def to_s
    name
  end

  def generate_adv_cat_permalink
    self.permalink = Russian.translit(name).parameterize if permalink.blank?
  end



end
