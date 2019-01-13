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

ActiveRecord::Schema.define(version: 20181006190715) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "stripe_customer_token"
    t.float "rank", default: 5.0
    t.string "card_id"
    t.string "open_pay_user_id"
    t.string "token"
    t.string "open_pay_clabe_id"
    t.text "phrase", default: ""
    t.string "last_name", default: ""
    t.boolean "master_control", default: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "archive_classrooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "archivo_file_name"
    t.string "archivo_content_type"
    t.integer "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.integer "classroom_id"
    t.index ["classroom_id"], name: "index_archive_classrooms_on_classroom_id"
  end

  create_table "archives", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "archivo_file_name"
    t.string "archivo_content_type"
    t.integer "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.integer "homework_id"
    t.index ["homework_id"], name: "index_archives_on_homework_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "classroom_id"
    t.index ["admin_id"], name: "index_chat_rooms_on_admin_id"
    t.index ["classroom_id"], name: "index_chat_rooms_on_classroom_id"
    t.index ["user_id"], name: "index_chat_rooms_on_user_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.integer "homework_id"
    t.integer "status"
    t.integer "user_id"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "scoreTrabajador"
    t.integer "proposal_id"
    t.boolean "user_accepts"
    t.boolean "finished", default: false
    t.string "transaction_id"
    t.datetime "finished_date"
    t.index ["admin_id"], name: "index_classrooms_on_admin_id"
    t.index ["homework_id"], name: "index_classrooms_on_homework_id"
    t.index ["proposal_id"], name: "index_classrooms_on_proposal_id"
    t.index ["user_id"], name: "index_classrooms_on_user_id"
  end

  create_table "earnings", force: :cascade do |t|
    t.float "money"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_earnings_on_admin_id"
  end

  create_table "homeworks", force: :cascade do |t|
    t.datetime "deadline"
    t.text "description"
    t.text "name"
    t.integer "numberpages"
    t.integer "user_id"
    t.integer "admin_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tipo"
    t.integer "status", default: 1
    t.integer "minPrice"
    t.integer "maxPrice"
    t.index ["admin_id"], name: "index_homeworks_on_admin_id"
    t.index ["user_id"], name: "index_homeworks_on_user_id"
  end

  create_table "levels", force: :cascade do |t|
    t.text "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.integer "admin_id"
    t.integer "chat_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_messages_on_admin_id"
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notification_workers", force: :cascade do |t|
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_type"
    t.integer "item_id"
    t.boolean "viewed", default: false
    t.string "notification_type", default: ""
    t.index ["admin_id"], name: "index_notification_workers_on_admin_id"
    t.index ["item_type", "item_id"], name: "index_notification_workers_on_item_type_and_item_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string "item_type"
    t.integer "item_id"
    t.boolean "viewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_notifications_on_item_type_and_item_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.integer "admin_id"
    t.integer "homework_id"
    t.float "cost"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deadline"
    t.integer "status", default: 1
    t.index ["admin_id"], name: "index_proposals_on_admin_id"
    t.index ["homework_id"], name: "index_proposals_on_homework_id"
  end

  create_table "scores", force: :cascade do |t|
    t.text "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tipo"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "firs_last_name"
    t.string "second_last_name"
    t.text "phone"
    t.integer "points"
    t.integer "status"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "stripe_customer_token"
    t.text "card1"
    t.float "rank", default: 5.0
    t.string "card_id"
    t.string "open_pay_user_id"
    t.string "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
