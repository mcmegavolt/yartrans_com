class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :personal_id
      t.string :phone_main
      t.string :phone_alternate

      t.timestamps
    end
  end
end
