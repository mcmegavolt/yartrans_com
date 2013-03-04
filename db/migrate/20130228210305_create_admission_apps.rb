class CreateAdmissionApps < ActiveRecord::Migration
  def change
    create_table :admission_apps do |t|
      t.integer :user_id
      t.string :barcode
      t.datetime :expected_date
      t.text :notes
      t.text :vehicle
      t.string :cargo_name
      t.string :code_number
      t.integer :unit_id
      t.integer :unit_count
      t.integer :in_box_count
      t.integer :box_count
      t.text :additional_info

      t.timestamps
    end
  end
end
