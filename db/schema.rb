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

ActiveRecord::Schema.define(version: 20171023070201) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_comments_on_request_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorite_votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "votable_type"
    t.bigint "votable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favorite_votes_on_user_id"
    t.index ["votable_type", "votable_id"], name: "index_favorite_votes_on_votable_type_and_votable_id"
  end

  create_table "requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.text "details"
    t.boolean "isPublic", null: false
    t.datetime "askTime", null: false
    t.integer "askUserId", null: false
    t.text "answer"
    t.datetime "answerTime"
    t.integer "answerUserId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "star_votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "votable_type"
    t.bigint "votable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_star_votes_on_user_id"
    t.index ["votable_type", "votable_id"], name: "index_star_votes_on_votable_type_and_votable_id"
  end

  create_table "user_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "userId"
    t.integer "questionId"
    t.boolean "isRequester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nickName", null: false
    t.string "profileUrl"
    t.string "username", null: false
    t.string "passwordHash", null: false
    t.string "salt", null: false
    t.string "email", null: false
    t.boolean "emailNotifications", default: true, null: false
    t.boolean "isAdmin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "requests"
  add_foreign_key "comments", "users"
  add_foreign_key "favorite_votes", "users"
  add_foreign_key "star_votes", "users"
end
