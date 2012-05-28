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

ActiveRecord::Schema.define(:version => 20120209132809) do

  create_table "admins", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",    :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true

  create_table "attendances", :force => true do |t|
    t.integer  "attendee_id"
    t.integer  "attended_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "attendances", ["attended_id"], :name => "index_attendances_on_attended_id"
  add_index "attendances", ["attendee_id"], :name => "index_attendances_on_attendee_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "nickname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "kit_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["kit_id"], :name => "index_comments_on_kit_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "dittos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "dittoable_id"
    t.string   "dittoable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "dittos", ["dittoable_id"], :name => "index_dittos_on_dittoable_id"
  add_index "dittos", ["user_id"], :name => "index_dittos_on_user_id"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status",     :default => "pending"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "interests", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invitations", :force => true do |t|
    t.integer  "user_id"
    t.string   "invitee_email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "kits", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "kitable_id"
    t.string   "kitable_type"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "kits", ["kitable_id"], :name => "index_kits_on_kitable_id"
  add_index "kits", ["user_id"], :name => "index_kits_on_user_id"

  create_table "majors", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_participations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.boolean  "read",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "message_participations", ["message_id"], :name => "index_message_participations_on_message_id"
  add_index "message_participations", ["user_id"], :name => "index_message_participations_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "moims", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.string   "location"
    t.datetime "event_time"
    t.boolean  "hasMap",         :default => false
    t.string   "mapCoordinates", :default => ":N/A"
    t.string   "mapAddress",     :default => ":N/A"
    t.integer  "moimable_id"
    t.string   "moimable_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "moims", ["moimable_id"], :name => "index_moims_on_moimable_id"
  add_index "moims", ["user_id"], :name => "index_moims_on_user_id"

  create_table "network_participations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "network_id"
    t.boolean  "approved",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "network_participations", ["network_id"], :name => "index_network_participations_on_network_id"
  add_index "network_participations", ["user_id"], :name => "index_network_participations_on_user_id"

  create_table "networks", :force => true do |t|
    t.string   "name"
    t.string   "network_type"
    t.string   "address"
    t.boolean  "privacy",                      :default => false
    t.integer  "network_participations_count", :default => 0
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "notification_settings", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "kit_notify",                   :default => true
    t.boolean  "seed_kit_notify",              :default => true
    t.boolean  "moim_kit_notify",              :default => true
    t.boolean  "comment_notify",               :default => true
    t.boolean  "other_comment_notify",         :default => true
    t.boolean  "reply_notify",                 :default => true
    t.boolean  "friendship_notify",            :default => true
    t.boolean  "friendship_acceptance_notify", :default => true
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "notification_type"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.boolean  "read",              :default => false
    t.string   "message"
    t.string   "subject"
    t.string   "url"
    t.integer  "sender_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "participations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "seed_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "participations", ["seed_id"], :name => "index_participations_on_seed_id"
  add_index "participations", ["user_id"], :name => "index_participations_on_user_id"

  create_table "password_resets", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.integer  "photoable_id"
    t.string   "photoable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "photos", ["photoable_id"], :name => "index_photos_on_photoable_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "replies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "replies", ["message_id"], :name => "index_replies_on_message_id"
  add_index "replies", ["user_id"], :name => "index_replies_on_user_id"

  create_table "seeds", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "seeds", ["user_id"], :name => "index_seeds_on_user_id"

  create_table "supports", :force => true do |t|
    t.integer  "user_id"
    t.integer  "seed_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "supports", ["seed_id"], :name => "index_supports_on_seed_id"
  add_index "supports", ["user_id"], :name => "index_supports_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "birthday"
    t.string   "cellphone"
    t.integer  "avatar_file_size"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.boolean  "admin",                  :default => false
    t.string   "profile"
    t.string   "remember_token"
    t.string   "major_detail"
    t.integer  "major_id"
    t.integer  "interest_id"
    t.string   "sex"
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
