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

ActiveRecord::Schema.define(:version => 20120213194101) do

  create_table "bunkai", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "kata_id"
  end

  create_table "bunkai_techniques", :force => true do |t|
    t.integer "bunkai_id"
    t.integer "technique_id"
  end

  add_index "bunkai_techniques", ["bunkai_id"], :name => "index_bunkais_techniques_on_bunkai_id"
  add_index "bunkai_techniques", ["technique_id"], :name => "index_bunkais_techniques_on_technique_id"

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "bunkai_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["bunkai_id"], :name => "index_comments_on_bunkai_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "kata", :force => true do |t|
    t.text     "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "style_id"
  end

  create_table "maneuvers", :force => true do |t|
    t.text     "description"
    t.string   "actor"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "bunkai_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "styles", :force => true do |t|
    t.string   "name"
    t.integer  "kata_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "styles", ["name"], :name => "index_styles_on_name", :unique => true

  create_table "techniques", :force => true do |t|
    t.text     "description"
    t.integer  "kata_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "name"
    t.boolean  "editor",                                :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
