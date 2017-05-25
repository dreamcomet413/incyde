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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160608211048) do

  create_table "archives", force: true do |t|
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  create_table "article_categories", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "author_type"
    t.integer  "author_id"
    t.string   "title"
    t.text     "description"
    t.text     "body"
    t.boolean  "featured",                        default: false
    t.boolean  "public",                          default: false
    t.string   "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "published_at"
    t.string   "image_url",          limit: 1000
    t.string   "imported_url",       limit: 1000
    t.integer  "category_id"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  add_index "articles", ["category_id"], name: "index_articles_on_category_id", using: :btree

  create_table "business_incubator_profiles", force: true do |t|
    t.integer  "business_incubator_id"
    t.string   "name"
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "address"
    t.string   "zip_code"
    t.string   "phone"
    t.string   "fax"
    t.string   "web"
    t.string   "recipient_agency"
    t.string   "managing_agency"
    t.string   "contact_name"
    t.integer  "kind"
    t.string   "offices_count"
    t.string   "industrial_unit_count"
    t.string   "meeting_rooms_count"
    t.string   "training_rooms_count"
    t.boolean  "assembly_hall"
    t.boolean  "parking"
    t.string   "parking_count"
    t.boolean  "preincubation_zone"
    t.boolean  "video_surveillance"
    t.boolean  "electronic_access"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_url",          limit: 1000
    t.string   "twitter_url",           limit: 1000
  end

  add_index "business_incubator_profiles", ["business_incubator_id"], name: "index_business_incubator_profiles_on_business_incubator_id", using: :btree
  add_index "business_incubator_profiles", ["city_id"], name: "index_business_incubator_profiles_on_city_id", using: :btree
  add_index "business_incubator_profiles", ["country_id"], name: "index_business_incubator_profiles_on_country_id", using: :btree
  add_index "business_incubator_profiles", ["province_id"], name: "index_business_incubator_profiles_on_province_id", using: :btree
  add_index "business_incubator_profiles", ["region_id"], name: "index_business_incubator_profiles_on_region_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["province_id"], name: "index_cities_on_province_id", using: :btree

  create_table "company_profiles", force: true do |t|
    t.integer  "company_id"
    t.integer  "business_incubator_profile_id"
    t.integer  "sector_id"
    t.string   "name"
    t.date     "incorporation_date"
    t.date     "start_at"
    t.date     "end_at"
    t.string   "contact_name"
    t.string   "contact_surname"
    t.string   "contact_nif"
    t.string   "cnae"
    t.integer  "workers_number"
    t.string   "land_phone"
    t.string   "mobile_phone"
    t.string   "fax"
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "address"
    t.string   "zip_code"
    t.string   "activity"
    t.string   "web"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "space"
    t.datetime "start_at_in_business_incubator"
    t.datetime "end_at_in_business_incubator"
    t.text     "offer_description"
    t.boolean  "legal_conditions",               default: true
  end

  add_index "company_profiles", ["business_incubator_profile_id"], name: "index_company_profiles_on_business_incubator_profile_id", using: :btree
  add_index "company_profiles", ["city_id"], name: "index_company_profiles_on_city_id", using: :btree
  add_index "company_profiles", ["company_id"], name: "index_company_profiles_on_company_id", using: :btree
  add_index "company_profiles", ["country_id"], name: "index_company_profiles_on_country_id", using: :btree
  add_index "company_profiles", ["province_id"], name: "index_company_profiles_on_province_id", using: :btree
  add_index "company_profiles", ["region_id"], name: "index_company_profiles_on_region_id", using: :btree
  add_index "company_profiles", ["sector_id"], name: "index_company_profiles_on_sector_id", using: :btree

  create_table "conferences", force: true do |t|
    t.string   "author_type"
    t.integer  "author_id"
    t.string   "name"
    t.string   "room"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "content_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_likes", ["likeable_id", "likeable_type"], name: "index_content_likes_on_likeable_id_and_likeable_type", using: :btree
  add_index "content_likes", ["user_id"], name: "index_content_likes_on_user_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "notification_platforms", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.string   "author_type"
  end

  add_index "notification_platforms", ["author_id", "author_type"], name: "index_notification_platforms_on_author_id_and_author_type", using: :btree

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provinces", ["region_id"], name: "index_provinces_on_region_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["country_id"], name: "index_regions_on_country_id", using: :btree

  create_table "sectors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seminars", force: true do |t|
    t.string   "name"
    t.string   "url",                limit: 1000
    t.datetime "start_at"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "author_id"
    t.string   "author_type"
  end

  add_index "seminars", ["author_id", "author_type"], name: "index_seminars_on_author_id_and_author_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "type"
    t.string   "email",                       default: "",    null: false
    t.string   "encrypted_password",          default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "position_business_incubator"
    t.datetime "deactivated_at"
    t.integer  "parent_account_id"
    t.string   "name"
    t.boolean  "hide_messaging",              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", name: "mb_opt_outs_on_conversations_id", column: "conversation_id"

  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end
