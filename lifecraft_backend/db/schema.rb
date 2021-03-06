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

ActiveRecord::Schema.define(:version => 20120722135038) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "url"
  end

  create_table "quests", :force => true do |t|
    t.integer "user_id"
    t.integer "activity_id"
    t.boolean "completed",   :default => false, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "nickname"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "crypted_password",  :default => "", :null => false
    t.string   "password_salt",     :default => "", :null => false
    t.string   "persistence_token", :default => "", :null => false
    t.integer  "experience",        :default => 0,  :null => false
    t.integer  "level",             :default => 1,  :null => false
  end

end
