# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131104201307) do

  create_table "activity_feeds", :force => true do |t|
    t.string   "class_name"
    t.integer  "record_id"
    t.integer  "event_type_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "admission_apps", :force => true do |t|
    t.integer  "user_id"
    t.text     "notes"
    t.text     "vehicle"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.time     "admission_time"
    t.date     "admission_date"
    t.string   "file"
    t.integer  "staff_id"
    t.string   "state"
  end

  add_index "admission_apps", ["staff_id"], :name => "index_admission_apps_on_staff_id"

  create_table "admission_items", :force => true do |t|
    t.string   "name"
    t.string   "code_number"
    t.string   "bar_code"
    t.integer  "unit_id"
    t.integer  "unit_count"
    t.integer  "in_box_count"
    t.integer  "box_count"
    t.integer  "box_weight"
    t.integer  "box_size"
    t.text     "add_services"
    t.integer  "admission_app_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "admission_items", ["admission_app_id"], :name => "index_admission_items_on_admission_app_id"

  create_table "article_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "ancestry"
    t.integer  "position",    :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "permalink"
    t.string   "icon"
    t.string   "slogan"
    t.boolean  "is_featured"
  end

  create_table "article_meta", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.boolean  "use_article_title", :default => false
    t.integer  "metaable_id"
    t.string   "metaable_type"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "article_meta", ["metaable_id"], :name => "index_article_meta_on_metaable_id"
  add_index "article_meta", ["metaable_type"], :name => "index_article_meta_on_metaable_type"

  create_table "article_pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "permalink"
    t.integer  "position"
    t.integer  "category_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "entry"
    t.boolean  "published",   :default => false
    t.string   "slogan"
    t.string   "icon"
  end

  create_table "article_widgets", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "widgetable_id"
    t.string   "widgetable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "news_items", :force => true do |t|
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               :default => false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.string   "personal_id"
    t.string   "phone_main"
    t.string   "phone_alternate"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.string   "alt_email"
  end

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "release_apps", :force => true do |t|
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "release_date"
    t.time     "release_time"
    t.text     "recipient"
    t.text     "vehicle"
    t.string   "file"
    t.integer  "staff_id"
    t.string   "state"
  end

  add_index "release_apps", ["staff_id"], :name => "index_release_apps_on_staff_id"

  create_table "release_items", :force => true do |t|
    t.string   "name"
    t.string   "code_number"
    t.string   "bar_code"
    t.integer  "unit_id"
    t.integer  "unit_count"
    t.integer  "box_count"
    t.text     "add_services"
    t.integer  "release_app_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "release_items", ["release_app_id"], :name => "index_release_items_on_release_app_id"

  create_table "reports", :force => true do |t|
    t.string   "file"
    t.integer  "report_category_id"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "staffs", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "staffs", ["user_id"], :name => "index_staffs_on_user_id"

  create_table "tariffs", :force => true do |t|
    t.text     "notes"
    t.string   "file"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tariffs", ["user_id"], :name => "index_tariffs_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "state"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
