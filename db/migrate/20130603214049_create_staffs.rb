class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :email
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :staffs, :user_id
  end
end
