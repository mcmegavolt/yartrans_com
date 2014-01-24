class Article::Page < ActiveRecord::Base

  attr_accessible :title, :slogan, :body, :category_id, :position, :permalink,
                  :published, :entry,
                  :icon, :icon_cache, :remove_icon,
                  :meta_attributes,
                  :widget_attributes,
                  :sub_section_attributes

  belongs_to :category, :class_name => Article::Category

  has_one :meta, :as => :metaable, :class_name => Article::Meta, :dependent => :destroy
  accepts_nested_attributes_for :meta, :reject_if => proc { |attr| attr[:title].blank? && attr[:description].blank? && attr[:keywords].blank? }

  has_one :widget, :as => :widgetable, :class_name => Article::Widget, :dependent => :destroy
  accepts_nested_attributes_for :widget, :reject_if => proc { |attr| attr[:body].blank? }

  has_one :sub_section, :as => :sub_sectionable, :class_name => Article::SubSection, :dependent => :destroy
  accepts_nested_attributes_for :sub_section, :reject_if => proc { |attr| attr[:title].blank? }

  before_save :generate_adv_page_permalink

  validates_uniqueness_of :permalink

  default_scope order('position ASC')

  scope :static, where(:category_id => nil)

  mount_uploader :icon, PageIconUploader

  def to_param
    permalink
  end

  def to_s
    title
  end

  def is_static?
    self.category_id.nil?
  end


  def generate_adv_page_permalink
    self.permalink = Russian.translit(title).parameterize if permalink.blank?
  end


end
