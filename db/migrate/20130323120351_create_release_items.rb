class CreateReleaseItems < ActiveRecord::Migration
  def change
    create_table :release_items do |t|
      t.string :name
      t.string :code_number
      t.string :bar_code
      t.integer :unit_id
      t.integer :unit_count
      t.integer :box_count
      t.text :add_services
      t.references :release_app

      t.timestamps
    end
    add_index :release_items, :release_app_id
  end
end
