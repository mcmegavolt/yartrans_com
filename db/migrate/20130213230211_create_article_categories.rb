class CreateArticleCategories < ActiveRecord::Migration
  def self.up
    create_table :article_categories do |t|
      t.string :name
      t.text :description
      t.string :ancestry
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :article_categories
  end
end
