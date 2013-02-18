class CreateArticlePages < ActiveRecord::Migration
  def up
      create_table :article_pages do |t|
      t.string :title
      t.text :body
      t.string :permalink
      t.integer :position
      t.integer :category_id
      t.timestamps
    end
  end

  def down
  end
end
