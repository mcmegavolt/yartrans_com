class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|
      t.text :notes
      t.string :file
      t.references :user

      t.timestamps
    end
    add_index :tariffs, :user_id
  end
end
