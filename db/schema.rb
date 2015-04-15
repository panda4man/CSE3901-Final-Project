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

ActiveRecord::Schema.define(version: 20150414013157) do

  create_table "games", force: :cascade do |t|
    t.integer  "first_user_id"
    t.integer  "second_user_id"
    t.string   "name"
    t.string   "word"
    t.integer  "level",                default: 1
    t.datetime "start_time"
    t.string   "invitee_email"
    t.integer  "first_user_progress",  default: 0
    t.integer  "second_user_progress", default: 0
    t.integer  "first_user_points",    default: 500
    t.integer  "second_user_points",   default: 500
    t.integer  "winner"
    t.integer  "loser"
    t.integer  "player_one_draw"
    t.integer  "player_two_draw"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "leader_boards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lobbies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "email"
    t.string   "username"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "users", ["game_id"], name: "index_users_on_game_id"

end
