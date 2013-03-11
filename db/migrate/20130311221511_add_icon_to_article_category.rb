class AddIconToArticleCategory < ActiveRecord::Migration
  def change
    add_column :article_categories, :icon, :string
  end
end
