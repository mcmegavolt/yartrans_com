class AddPublishedAndEntryToArticlePage < ActiveRecord::Migration
  def change
    add_column :article_pages, :entry, :text
    add_column :article_pages, :published, :boolean, :default => false
  end
end
