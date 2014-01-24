class CreateArticleSubSectionItems < ActiveRecord::Migration
  def change
    create_table :article_sub_section_items do |t|
      t.integer :sub_section_id
      t.text :entry
      t.text :body
      t.string :title
      t.string :caption
      t.string :photo

      t.timestamps
    end
  end
end
