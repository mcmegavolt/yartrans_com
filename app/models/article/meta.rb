class Article::Meta < ActiveRecord::Base
  attr_accessible :description, :keywords, :title, :use_article_title
  belongs_to :metaable, :polymorphic => true
end
