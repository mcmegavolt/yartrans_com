class AddFeaturedToArticleCategory < ActiveRecord::Migration
  def change
    add_column :article_categories, :is_featured, :boolean
  end
end
