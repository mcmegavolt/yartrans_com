class AddIconToArticlePage < ActiveRecord::Migration
  def change
    add_column :article_pages, :icon, :string
  end
end
