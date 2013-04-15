class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :file
      t.integer :report_category_id
      t.references :user

      t.timestamps
    end
    add_index :reports, :user_id
  end
end
