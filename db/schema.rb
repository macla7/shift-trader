# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_14_004121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "identities", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "invitor_id", null: false
    t.integer "invitee_id"
    t.integer "user_group_id"
    t.boolean "confirmed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "accepted", default: false
    t.index ["invitor_id"], name: "index_invites_on_invitor_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "body"
    t.datetime "time_end"
    t.bigint "user_id", null: false
    t.bigint "user_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_group_id"], name: "index_posts_on_user_group_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "friend_id"
    t.boolean "accepted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "time_start"
    t.datetime "time_end"
    t.string "position"
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_shifts_on_post_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.string "name"
    t.integer "host_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "phone_number"
    t.boolean "verified", default: false
    t.boolean "oauth_registered_only", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "identities", "users"
  add_foreign_key "invites", "users", column: "invitor_id"
  add_foreign_key "posts", "user_groups"
  add_foreign_key "posts", "users"
  add_foreign_key "requests", "users"
  add_foreign_key "shifts", "posts"
end
