class CreateArticleSubSections < ActiveRecord::Migration
  def change
    create_table :article_sub_sections do |t|
      t.string :title
      t.integer :sub_sectionable_id
      t.string :sub_sectionable_type

      t.timestamps
    end
  end
end
