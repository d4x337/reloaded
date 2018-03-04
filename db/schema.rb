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

ActiveRecord::Schema.define(version: 20171228113752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "url"
    t.string   "action"
    t.integer  "active",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expire_at"
    t.integer  "customer_id",        default: 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.string   "type"
    t.string   "locale",             default: "it"
    t.integer  "viewed"
    t.string   "visibility"
  end

  add_index "ads", ["title"], name: "index_ads_on_title", unique: true, using: :btree

  create_table "alias_maps", force: :cascade do |t|
    t.text     "address"
    t.string   "alias",      default: ""
    t.string   "domain",     default: ""
    t.integer  "active",     default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", force: :cascade do |t|
    t.string   "fullname"
    t.string   "country"
    t.string   "dates"
    t.string   "headline"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blocked_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "blocked_id"
    t.datetime "blocked_at"
    t.text     "reason",     default: "null"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_settings", force: :cascade do |t|
    t.integer "blog_id"
    t.string  "border_color"
    t.string  "text_color"
    t.string  "background_color"
    t.boolean "allow_comments",   default: true
  end

  create_table "blogs", force: :cascade do |t|
    t.integer "owner_id"
    t.string  "title"
    t.string  "motto"
    t.text    "description"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.float    "single_price"
    t.float    "vats"
    t.float    "total_price"
    t.float    "shipping_costs"
    t.boolean  "is_in_stock"
    t.datetime "last_operation"
    t.boolean  "deleted",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_products", force: :cascade do |t|
    t.integer "cart_id",                  null: false
    t.integer "product_id",               null: false
    t.integer "quantity",     default: 1, null: false
    t.decimal "single_price"
    t.decimal "total_price"
    t.string  "nickname"
    t.string  "domain"
    t.string  "status"
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "order_id",                    default: 0
    t.string   "domain"
    t.string   "nick"
    t.string   "prod_id"
    t.integer  "items"
    t.string   "currency"
    t.string   "status"
    t.string   "promo"
    t.decimal  "total_price"
    t.string   "ip"
    t.datetime "purchased_at"
    t.datetime "last_operation"
    t.boolean  "deleted",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invitation_id"
    t.string   "invitation_token", limit: 60
    t.string   "request_token"
    t.integer  "years"
    t.integer  "user_id"
  end

  create_table "channel_users", force: :cascade do |t|
    t.integer  "channel_id"
    t.string   "user_id"
    t.datetime "join_at"
    t.boolean  "invited",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "banner"
    t.string   "chan_type"
    t.datetime "last_message"
    t.integer  "current_users"
    t.integer  "max_users"
    t.text     "reason",        default: "null"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "coupon_id"
    t.integer  "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "target_id"
    t.string   "from",       limit: 255, default: "", null: false
    t.string   "to",         limit: 255, default: "", null: false
    t.text     "message",                             null: false
    t.datetime "sent",                                null: false
    t.integer  "recd",                   default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chats", ["from"], name: "index_chats_on_from", using: :btree
  add_index "chats", ["to"], name: "index_chats_on_to", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id"
    t.text     "author"
    t.string   "author_email"
    t.string   "author_url"
    t.string   "author_ip"
    t.datetime "date"
    t.datetime "date_gmt"
    t.text     "content"
    t.integer  "karma"
    t.string   "approved"
    t.string   "agent"
    t.string   "type"
    t.integer  "parent"
    t.string   "user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "fullname"
    t.string   "address"
    t.string   "city"
    t.string   "company"
    t.string   "headline"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "email"
    t.string   "mobile"
    t.string   "gender"
    t.datetime "birthdate"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["fullname"], name: "index_contacts_on_fullname", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string "country_code"
    t.string "country_name"
  end

  add_index "countries", ["country_code"], name: "index_countries_on_country_code", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "discount_percent"
    t.datetime "expires_at"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", force: :cascade do |t|
    t.string   "domain"
    t.string   "description"
    t.integer  "aliases",     default: 0
    t.integer  "mailboxes",   default: 0
    t.integer  "maxquota",    default: 0
    t.integer  "backupmx",    default: 0
    t.string   "transport"
    t.integer  "active",      default: 1
    t.datetime "expire_at"
    t.string   "homedir"
    t.string   "vmaildir"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["domain"], name: "index_domains_on_domain", unique: true, using: :btree

  create_table "efiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "original_file_name"
    t.string   "original_content_type"
    t.integer  "original_file_size"
    t.datetime "original_updated_at"
    t.string   "encoded_filename"
    t.string   "encoded_size"
    t.string   "encrypted_key"
    t.string   "encrypted_key_salt"
    t.string   "encrypted_key_iv"
    t.string   "encrypted_entropy"
    t.string   "encrypted_entropy_salt"
    t.string   "encrypted_entropy_iv"
    t.boolean  "compressed",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "from"
    t.string   "email"
    t.string   "reason"
    t.text     "message"
    t.integer  "rating"
    t.string   "ip"
    t.string   "country"
    t.datetime "sent_at"
    t.boolean  "deleted",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "feedtag"
    t.string   "feedtext"
    t.string   "locale"
    t.string   "feedicon_file_name"
    t.string   "feedicon_content_type"
    t.integer  "feedicon_file_size"
    t.datetime "feedicon_updated_at"
    t.integer  "vote"
    t.boolean  "active",                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "deleted",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "relation"
  end

  create_table "group_members", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.string   "role"
    t.integer  "invited_by"
    t.integer  "promoted_by"
    t.integer  "removed_by"
    t.datetime "join_date"
    t.datetime "leave_date"
    t.boolean  "active",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "headline"
    t.text     "description"
    t.text     "motto"
    t.string   "founder"
    t.integer  "members"
    t.integer  "admins"
    t.string   "visibility",         default: "PUBLIC"
    t.datetime "creation_date"
    t.text     "mission"
    t.boolean  "deleted",            default: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "income_id"
    t.integer  "order_id"
    t.string   "status"
    t.boolean  "una_tantum",  default: false
    t.decimal  "income"
    t.string   "income_type"
    t.datetime "expiration"
    t.boolean  "auto_renew"
    t.boolean  "deleted",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.string   "subject"
    t.text     "reason"
    t.boolean  "accepted",        default: false
    t.boolean  "email_sent",      default: false
    t.boolean  "archivied",       default: false
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_rows", force: :cascade do |t|
    t.integer  "product_id"
    t.decimal  "single"
    t.integer  "quantity"
    t.decimal  "total"
    t.decimal  "vats"
    t.boolean  "in_stock"
    t.datetime "arrival_date"
    t.boolean  "shipped",      default: false
    t.boolean  "payed",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "invoice_date"
    t.string   "invoice_year"
    t.string   "email"
    t.integer  "quantity"
    t.boolean  "subscription",  default: true
    t.boolean  "annual",        default: true
    t.datetime "starts_on"
    t.datetime "expires_on"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "zip"
    t.string   "town"
    t.string   "city"
    t.string   "country"
    t.string   "telephone"
    t.decimal  "total"
    t.string   "ip_address"
    t.boolean  "only_services", default: false
    t.boolean  "payed",         default: true
    t.boolean  "delivered",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iposts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: :cascade do |t|
    t.string  "iso_language"
    t.string  "locale"
    t.string  "en_desc"
    t.boolean "default"
    t.boolean "active"
  end

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.string   "target",             default: "_blank"
    t.string   "description"
    t.integer  "current_pos"
    t.integer  "last_pos"
    t.string   "trend"
    t.integer  "user_id"
    t.boolean  "visible",            default: true
    t.integer  "rating",             default: 6
    t.string   "rss"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "login"
    t.string   "name"
    t.string   "password"
    t.string   "tip"
    t.integer  "uid",        default: 2000
    t.integer  "gid",        default: 2000
    t.string   "home",       default: "/var/vmail"
    t.string   "maildir",    default: "d4x337.com/username"
    t.string   "quota",      default: "1000000000S"
    t.integer  "active",     default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "defaultbox", default: true
  end

  add_index "mail_accounts", ["login"], name: "index_mail_accounts_on_login", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "target_id"
    t.integer  "chat_id"
    t.string   "target_name"
    t.string   "notify_link"
    t.string   "read_token"
    t.text     "sha512"
    t.text     "bfk"
    t.text     "tfk"
    t.text     "tfe"
    t.text     "aek"
    t.text     "tdk"
    t.text     "tde"
    t.text     "encoded"
    t.text     "decoded"
    t.text     "public_key"
    t.text     "cipher"
    t.text     "private_key"
    t.boolean  "delivered",               default: false
    t.text     "content"
    t.boolean  "secured",                 default: false
    t.string   "public"
    t.string   "private"
    t.string   "msghash"
    t.string   "link"
    t.boolean  "autodestroy",             default: true
    t.string   "message",     limit: 255
    t.boolean  "deleted",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "enc_shared"
  end

  create_table "mini_post_comment_likings", force: :cascade do |t|
    t.boolean  "liking"
    t.datetime "created_at",                           null: false
    t.integer  "mini_post_comment_id", default: 0,     null: false
    t.integer  "user_id",              default: 0,     null: false
    t.boolean  "deleted",              default: false
  end

  create_table "mini_post_comments", force: :cascade do |t|
    t.integer  "mini_post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.string   "author_ip"
    t.text     "content"
    t.integer  "karma"
    t.boolean  "approved",       default: false
    t.boolean  "deleted",        default: false
    t.boolean  "removed",        default: false
    t.text     "removal_reason"
    t.integer  "moderator"
    t.string   "user_agent"
    t.string   "user_arch"
    t.integer  "parent_id",      default: 0
  end

  create_table "mini_post_favorites", force: :cascade do |t|
    t.boolean  "favorite",     default: true
    t.datetime "created_at",                   null: false
    t.integer  "mini_post_id", default: 0,     null: false
    t.integer  "user_id",      default: 0,     null: false
    t.boolean  "deleted",      default: false
  end

  create_table "mini_post_feeds", force: :cascade do |t|
    t.integer  "mini_post_id"
    t.integer  "user_id"
    t.string   "feedtag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mini_post_likings", force: :cascade do |t|
    t.boolean  "liking",       default: true
    t.datetime "created_at",                   null: false
    t.integer  "mini_post_id", default: 0,     null: false
    t.integer  "user_id",      default: 0,     null: false
    t.boolean  "deleted",      default: false
  end

  create_table "mini_post_tags", force: :cascade do |t|
    t.integer  "mini_post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mini_posts", force: :cascade do |t|
    t.integer  "author_id"
    t.text     "content"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ext_url"
    t.string   "visibility",          default: "FRIEND"
    t.string   "comment_status"
    t.boolean  "is_a_comment",        default: false
    t.boolean  "has_image",           default: false
    t.boolean  "has_url",             default: false
    t.integer  "likes",               default: 0
    t.integer  "dislikes",            default: 0
    t.integer  "rating"
    t.integer  "popularity"
    t.integer  "parent_mini_post_id", default: 0
    t.boolean  "is_delay_publish",    default: false
    t.datetime "delay_publish_date"
    t.boolean  "is_auto_destroy",     default: false
    t.datetime "destroy_at"
    t.boolean  "removed"
    t.string   "rem_category"
    t.text     "reason"
    t.string   "author_ip"
    t.string   "author_device"
    t.text     "review_admin_notes"
    t.boolean  "deleted",             default: false
    t.integer  "group_id",            default: 0
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "target_id"
    t.string   "reason"
    t.text     "message"
    t.integer  "kind_of"
    t.boolean  "read",       default: false
    t.datetime "sent_at"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.string   "friendly"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.boolean  "subscription",        default: true
    t.boolean  "annual",              default: true
    t.datetime "starts_on"
    t.datetime "expires_on"
    t.string   "email"
    t.integer  "invoice_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "zip"
    t.string   "city"
    t.string   "town"
    t.string   "country"
    t.string   "telephone"
    t.string   "shipping_first_name"
    t.string   "shipping_last_name"
    t.string   "shipping_address"
    t.string   "shipping_zip"
    t.string   "shipping_city"
    t.string   "shipping_town"
    t.string   "shipping_country"
    t.string   "shipping_telephone"
    t.text     "customer_notes"
    t.text     "internal_notes"
    t.decimal  "total"
    t.boolean  "only_services",       default: false
    t.boolean  "payed",               default: false
    t.boolean  "delivered",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "billing_address"
    t.string   "billing_email"
    t.string   "first_pass"
    t.string   "transaction_id"
    t.string   "status"
    t.string   "amount"
    t.string   "currency"
  end

  create_table "payment_notifications", force: :cascade do |t|
    t.integer  "cart_id"
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "income_id"
    t.integer  "order_id"
    t.string   "status"
    t.boolean  "una_tantum",  default: false
    t.decimal  "income"
    t.string   "income_type"
    t.datetime "expiration"
    t.boolean  "auto_renew"
    t.boolean  "deleted",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string   "user_id"
    t.string   "phone_number"
    t.string   "pin"
    t.string   "action_type"
    t.boolean  "verified",      default: false
    t.boolean  "authenticated", default: false
    t.datetime "verified_at"
    t.boolean  "confirm",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "album_id",         default: 0
    t.string   "caption"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.boolean  "deleted",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_tags", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "author"
    t.datetime "date"
    t.datetime "gmt"
    t.text     "excerpt"
    t.string   "status"
    t.string   "visibility"
    t.string   "comment_status"
    t.string   "ping_status"
    t.string   "password"
    t.string   "name"
    t.text     "to_ping"
    t.text     "pinged"
    t.datetime "published"
    t.datetime "modified"
    t.datetime "modified_gmt"
    t.text     "content_filtered"
    t.integer  "parent",             default: 0
    t.string   "guid"
    t.integer  "menu_order",         default: 0
    t.string   "content_type"
    t.string   "mime_type"
    t.integer  "comment_count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "blog_id"
    t.text     "description"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "summary"
    t.float    "final_price"
    t.float    "costs"
    t.string   "category"
    t.string   "currency"
    t.string   "quota"
    t.string   "subscription"
    t.boolean  "pay_once"
    t.boolean  "in_stock",           default: true
    t.boolean  "promo",              default: false
    t.boolean  "active",             default: true
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quote_types", force: :cascade do |t|
    t.string   "type_of_quote"
    t.boolean  "visible",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: :cascade do |t|
    t.text     "qtext"
    t.string   "lang"
    t.integer  "author_id"
    t.integer  "user_id"
    t.integer  "quote_type_id"
    t.text     "notes"
    t.datetime "last_seen"
    t.datetime "next_seen"
    t.integer  "online_count",  default: 0
    t.boolean  "visible",       default: true
    t.boolean  "approved",      default: false
    t.boolean  "today",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "clicks"
    t.integer  "rating"
    t.datetime "published"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "fullname"
    t.string   "target_email"
    t.text     "message"
    t.string   "relation",           default: "PR"
    t.string   "status",             default: "PENDING"
    t.boolean  "answered",           default: false
    t.datetime "used_on"
    t.datetime "last_operation_on"
    t.datetime "expires_on"
    t.boolean  "never_expires",      default: true
    t.boolean  "know_in_real_world", default: true
    t.boolean  "deleted",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.integer  "target_id"
  end

  create_table "shadows", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "sender_email"
    t.string   "recipient_email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_hashtag_hashtaggings", force: :cascade do |t|
    t.integer "hashtag_id"
    t.integer "hashtaggable_id"
    t.string  "hashtaggable_type"
  end

  add_index "simple_hashtag_hashtaggings", ["hashtag_id"], name: "index_simple_hashtag_hashtaggings_on_hashtag_id", using: :btree
  add_index "simple_hashtag_hashtaggings", ["hashtaggable_id", "hashtaggable_type"], name: "index_hashtaggings_hashtaggable_id_hashtaggable_type", using: :btree

  create_table "simple_hashtag_hashtags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_hashtag_hashtags", ["name"], name: "index_simple_hashtag_hashtags_on_name", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status"
    t.boolean  "current"
    t.datetime "set_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.string  "slug"
    t.integer "term_group", default: 0
  end

  create_table "updates", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "target_id"
    t.string   "reason"
    t.text     "message"
    t.boolean  "read",       default: false
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "is_encrypted",           default: false
    t.string   "encoded_filename"
    t.string   "encoded_size"
    t.string   "encrypted_key"
    t.string   "encrypted_key_salt"
    t.string   "encrypted_key_iv"
    t.string   "encrypted_entropy"
    t.string   "encrypted_entropy_salt"
    t.string   "encrypted_entropy_iv"
    t.boolean  "compressed",             default: false
  end

  create_table "user_contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                    default: "",    null: false
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts"
    t.integer  "sign_in_count",                            default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "locked_at"
    t.string   "unlock_token"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",              limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "paypal_id"
    t.string   "telephone"
    t.string   "theme"
    t.datetime "last_seen"
    t.string   "nickname"
    t.string   "lastname"
    t.string   "firstname"
    t.string   "fullname"
    t.string   "gender"
    t.string   "country"
    t.date     "birthday"
    t.boolean  "approved",                                 default: true
    t.integer  "roles_mask"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "skype_id"
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.string   "linkedin_url"
    t.string   "other_url"
    t.string   "location"
    t.string   "work_at"
    t.string   "headline"
    t.text     "quote"
    t.text     "statement"
    t.string   "relation_status"
    t.string   "locale"
    t.boolean  "banned",                                   default: false
    t.integer  "chat_status",                              default: 0
    t.integer  "secret_question_id"
    t.string   "secret_answer"
    t.integer  "secret_question_id2"
    t.string   "secret_answer2"
    t.integer  "secret_question_id3"
    t.string   "secret_answer3"
    t.string   "mobile"
    t.string   "external_token"
    t.string   "status"
    t.boolean  "on_mobile",                                default: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_w"
    t.integer  "crop_h"
    t.integer  "order_id"
    t.datetime "updated_password_at"
    t.string   "avi_content_type"
    t.integer  "invitation_id"
    t.string   "twitter_user"
    t.string   "facebook_user"
    t.text     "favourite_quote"
    t.string   "invitations_list_file_name"
    t.string   "invitations_list_content_type"
    t.integer  "invitations_list_file_size"
    t.datetime "invitations_list_updated_at"
    t.binary   "iv"
    t.binary   "key"
    t.boolean  "show_email",                               default: true
    t.boolean  "show_mobile",                              default: true
    t.boolean  "show_last_access",                         default: true
    t.integer  "email_privacy",                            default: 0
    t.integer  "picture_privacy",                          default: 0
    t.integer  "status_privacy",                           default: 0
    t.integer  "last_access_privacy",                      default: 0
    t.integer  "global_search_privacy",                    default: 0
    t.string   "otp_secret_key"
    t.integer  "second_factor_attempts_count",             default: 0
    t.boolean  "two_factor_enabled",                       default: false
    t.datetime "mobile_confirmed_at"
    t.string   "card_token"
    t.string   "payment"
    t.string   "coupon"
    t.datetime "subscription_start"
    t.datetime "subscription_end"
    t.boolean  "payed",                                    default: true
    t.boolean  "warrant",                                  default: false
    t.string   "warrant_code"
    t.string   "warrant_date"
    t.text     "warrant_notes"
    t.text     "about"
    t.string   "instagram_id"
    t.string   "github_id"
    t.string   "background"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visitors", force: :cascade do |t|
    t.string   "session_id"
    t.string   "nickname"
    t.integer  "user_id"
    t.text     "user_agent"
    t.text     "headers"
    t.string   "visited_url"
    t.string   "remote_ip"
    t.string   "referer"
    t.string   "method"
    t.string   "remote_host"
    t.string   "http_accept"
    t.text     "query_string"
    t.text     "cookie_string"
    t.string   "geo_ip_country"
    t.string   "geo_ip_city"
    t.string   "cords"
    t.boolean  "active",         default: true
    t.boolean  "expired",        default: false
    t.datetime "expired_at"
    t.boolean  "deleted",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
