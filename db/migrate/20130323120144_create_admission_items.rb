class CreateAdmissionItems < ActiveRecord::Migration
  def change
    create_table :admission_items do |t|
      t.string :name
      t.string :code_number
      t.string :bar_code
      t.integer :unit_id
      t.integer :unit_count
      t.integer :in_box_count
      t.integer :box_count
      t.integer :box_weight
      t.integer :box_size
      t.text :add_services
      t.references :admission_app

      t.timestamps
    end
    add_index :admission_items, :admission_app_id
  end
end
