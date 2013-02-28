class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|
      t.string :class_name
      t.integer :record_id
      t.integer :event_type_id
      t.integer :user_id

      t.timestamps
    end
  end
end
