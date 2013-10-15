class CreateArticleMeta < ActiveRecord::Migration
  def change
    create_table :article_meta do |t|
      t.string :title
      t.text :description
      t.text :keywords
      t.boolean :use_article_title, default: false
      t.integer :metaable_id
      t.string :metaable_type

      t.timestamps
      
    end
    add_index :article_meta, :metaable_id
  	add_index :article_meta, :metaable_type
  end
end