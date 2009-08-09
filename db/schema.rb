# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090415034142) do

  create_table "articles", :force => true do |t|
    t.string "title"
    t.text   "lead"
    t.text   "detail"
    t.string "photo"
    t.string "tag"
    t.string "permalink"
    t.string "status"
    t.string "article_type"
  end

  create_table "comments", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.boolean  "approved",     :default => false, :null => false
    t.text     "comment"
    t.integer  "release_id"
    t.datetime "created_at"
    t.integer  "article_id"
    t.integer  "interview_id"
    t.integer  "resource_id"
    t.integer  "user_id"
    t.integer  "package_id"
    t.integer  "news_id"
    t.integer  "event_id"
  end

  create_table "contacts", :force => true do |t|
    t.string  "name"
    t.string  "email"
    t.text    "message"
    t.string  "user_ip"
    t.string  "user_agent"
    t.string  "referrer"
    t.boolean "approved",   :default => false, :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "event_url"
    t.date     "event_date"
    t.string   "headline"
    t.text     "description"
    t.string   "tags"
    t.integer  "user_id"
    t.string   "permalink"
    t.string   "status"
    t.datetime "created_at"
  end

  create_table "feeds", :force => true do |t|
    t.string   "tags"
    t.string   "release_types"
    t.string   "feedburner"
    t.string   "localfeed"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "chicklet"
  end

  create_table "interviews", :force => true do |t|
    t.string "title"
    t.text   "interview"
    t.string "photo"
    t.string "tag"
    t.string "permalink"
    t.string "name"
    t.text   "lead"
    t.string "status"
  end

  create_table "logged_exceptions", :force => true do |t|
    t.string   "exception_class"
    t.string   "controller_name"
    t.string   "action_name"
    t.text     "message"
    t.text     "backtrace"
    t.text     "environment"
    t.text     "request"
    t.datetime "created_at"
  end

  create_table "meta_datas", :force => true do |t|
    t.string "page"
    t.string "description"
    t.string "keywords"
    t.string "title"
    t.text   "content"
  end

  create_table "news", :force => true do |t|
    t.string   "news_url"
    t.string   "headline"
    t.text     "description"
    t.string   "tags"
    t.integer  "user_id"
    t.datetime "created_at"
    t.string   "permalink"
    t.string   "status"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "packages", :force => true do |t|
    t.string "title"
    t.text   "lead"
    t.text   "detail"
    t.string "logo"
    t.string "download"
    t.string "tag"
    t.string "permalink"
  end

  create_table "release_types", :force => true do |t|
    t.string "release_type"
  end

  create_table "releases", :force => true do |t|
    t.string  "name"
    t.text    "details"
    t.string  "download_url"
    t.string  "releasenotes_url"
    t.string  "tags"
    t.string  "release_type"
    t.string  "logo"
    t.string  "icon"
    t.integer "user_id"
    t.date    "created_at"
    t.string  "status"
    t.string  "permalink"
    t.date    "release_date"
    t.integer "votes_count",      :default => 0
    t.string  "website"
  end

  add_index "releases", ["tags"], :name => "tags"
  add_index "releases", ["tags"], :name => "tags_2"
  add_index "releases", ["tags"], :name => "tags_3"

  create_table "resources", :force => true do |t|
    t.string "title"
    t.text   "lead"
    t.text   "detail"
    t.string "photo"
    t.string "tag"
    t.string "permalink"
  end

  create_table "tags", :force => true do |t|
    t.string  "tag"
    t.integer "release_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "user_level"
    t.string   "promo_code"
    t.string   "identity_url"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
