class CreateReleaseApps < ActiveRecord::Migration
  def change
    create_table :release_apps do |t|
      t.string :cargo_name
      t.string :consignment
      t.string :code_number
      t.integer :unit_id
      t.integer :unit_count
      t.integer :in_box_count
      t.integer :box_count
      t.text :additional_info
      t.integer :user_id

      t.timestamps
    end
  end
end
