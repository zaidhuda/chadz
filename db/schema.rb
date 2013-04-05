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

ActiveRecord::Schema.define(:version => 20130206014600) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bans", :force => true do |t|
    t.integer  "creator"
    t.string   "ip"
    t.integer  "user_id"
    t.integer  "messagebox_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "bans", ["ip"], :name => "index_bans_on_ip"
  add_index "bans", ["messagebox_id"], :name => "index_bans_on_messagebox_id"
  add_index "bans", ["user_id"], :name => "index_bans_on_user_id"

  create_table "colors", :force => true do |t|
    t.integer  "messagebox_attribute_id"
    t.string   "topline",                 :default => "80BC00"
    t.string   "msgbox_name",             :default => "888888"
    t.string   "overall_background",      :default => "FFFFFF"
    t.string   "background",              :default => "F0F0F0"
    t.string   "foreground",              :default => "FFFFFF"
    t.string   "link",                    :default => "80BC00"
    t.string   "link_hover",              :default => "4E8A00"
    t.string   "small_link",              :default => "777777"
    t.string   "small_link_hover",        :default => "444444"
    t.string   "input",                   :default => "80BC00"
    t.string   "input_focus",             :default => "80BC00"
    t.string   "input_background",        :default => "F0F0F0"
    t.string   "border",                  :default => "DDDDDD"
    t.string   "border_light",            :default => "F0F0F0"
    t.string   "p",                       :default => "555555"
    t.string   "super",                   :default => "AAAAAA"
    t.string   "warning",                 :default => "FF3C46"
    t.string   "scrollbar_thumb",         :default => "DDDDDD"
    t.string   "scrollbar_background",    :default => "888888"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "colors", ["messagebox_attribute_id"], :name => "index_colors_on_messagebox_attribute_id"

  create_table "messagebox_attributes", :force => true do |t|
    t.integer  "messagebox_id"
    t.string   "color"
    t.text     "custom_css"
    t.boolean  "public"
    t.string   "url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "messagebox_attributes", ["messagebox_id"], :name => "index_messagebox_attributes_on_messagebox_id"

  create_table "messageboxes", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messageboxes", ["name"], :name => "index_messageboxes_on_name", :unique => true
  add_index "messageboxes", ["user_id"], :name => "index_messageboxes_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "content",       :null => false
    t.integer  "user_id"
    t.integer  "messagebox_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "messages", ["messagebox_id"], :name => "index_messages_on_messagebox_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "msg_fav_flags", :force => true do |t|
    t.boolean  "fav"
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "msg_fav_flags", ["message_id"], :name => "index_msg_fav_flags_on_message_id"
  add_index "msg_fav_flags", ["user_id"], :name => "index_msg_fav_flags_on_user_id"

  create_table "user_infos", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "user_name",  :null => false
    t.string   "avatar",     :null => false
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_infos", ["user_id"], :name => "index_user_infos_on_user_id"
  add_index "user_infos", ["user_name"], :name => "index_user_infos_on_user_name", :unique => true

  create_table "user_urls", :force => true do |t|
    t.integer  "user_info_id"
    t.string   "provider"
    t.string   "identifier"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "user_urls", ["user_info_id"], :name => "index_user_urls_on_user_info_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.boolean  "guest",                  :default => false
    t.string   "encrypted_password",     :default => "",    :null => false
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
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
