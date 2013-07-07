class AddSloganToArticlePage < ActiveRecord::Migration
  def change
    add_column :article_pages, :slogan, :string
  end
end
