class Article::Category < ActiveRecord::Base

  self.table_name = 'article_categories'

  attr_accessible :name, :description, :ancestry, :position, :permalink

  has_ancestry

  before_save :generate_adv_cat_permalink

  validates_uniqueness_of :permalink

  default_scope order('position ASC')

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
