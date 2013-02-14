class AddPermalinkToArticleCategory < ActiveRecord::Migration
  def change
    add_column :article_categories, :permalink, :string
  end
end
