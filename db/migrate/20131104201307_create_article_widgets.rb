class CreateArticleWidgets < ActiveRecord::Migration
  def change
    create_table :article_widgets do |t|
      t.string :name
      t.text :body
      t.integer :widgetable_id
      t.string :widgetable_type

      t.timestamps
    end
  end
end
