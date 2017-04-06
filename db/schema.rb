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

ActiveRecord::Schema.define(version: 20170406215610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forfeits", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "forfeit_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "played",     default: false
    t.index ["forfeit_id"], name: "index_games_on_forfeit_id", using: :btree
    t.index ["room_id"], name: "index_games_on_room_id", using: :btree
  end

  create_table "mobility_string_translations", force: :cascade do |t|
    t.string   "locale"
    t.string   "key"
    t.string   "value"
    t.integer  "translatable_id"
    t.string   "translatable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_string_translations_on_translatable_attribute", using: :btree
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_string_translations_on_keys", unique: true, using: :btree
    t.index ["translatable_type", "key", "value", "locale"], name: "index_mobility_string_translations_on_query_keys", using: :btree
  end

  create_table "mobility_text_translations", force: :cascade do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.integer  "translatable_id"
    t.string   "translatable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_text_translations_on_translatable_attribute", using: :btree
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_text_translations_on_keys", unique: true, using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.integer  "score",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["room_id"], name: "index_players_on_room_id", using: :btree
    t.index ["user_id"], name: "index_players_on_user_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "signs", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "player_id"
    t.index ["player_id"], name: "index_team_members_on_player_id", using: :btree
    t.index ["team_id"], name: "index_team_members_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "sign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "result"
    t.index ["game_id"], name: "index_teams_on_game_id", using: :btree
    t.index ["sign_id"], name: "index_teams_on_sign_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "messenger_id"
    t.string   "profile_pic_url"
    t.string   "messenger_locale"
    t.string   "gender"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "games", "forfeits"
  add_foreign_key "games", "rooms"
  add_foreign_key "players", "rooms"
  add_foreign_key "players", "users"
  add_foreign_key "team_members", "teams"
  add_foreign_key "teams", "games"
  add_foreign_key "teams", "signs"
end
