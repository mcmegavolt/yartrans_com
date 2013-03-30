class AddTitleToNewsItem < ActiveRecord::Migration
  def change
    add_column :news_items, :title, :string
  end
end
