class Article::Page < ActiveRecord::Base

  self.table_name = 'article_pages'

  attr_accessible :title, :slogan, :body, :category_id, :position, :permalink, :published, :entry

  belongs_to :category, :class_name => Article::Category

  before_save :generate_adv_page_permalink

  validates_uniqueness_of :permalink

  default_scope order('position ASC')

  scope :static, where(:category_id => nil)

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
