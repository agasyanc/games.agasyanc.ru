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

ActiveRecord::Schema[7.1].define(version: 2024_09_16_140009) do
  create_table "player_targets", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_targets_on_player_id"
    t.index ["target_id"], name: "index_player_targets_on_target_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["provider", "uid"], name: "index_players_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  create_table "switches", force: :cascade do |t|
    t.boolean "on", null: false
    t.datetime "time", null: false
    t.integer "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_switches_on_player_id"
  end

  create_table "targets", force: :cascade do |t|
    t.string "code"
    t.string "shape"
    t.string "moves"
    t.string "colors"
    t.string "transformation"
    t.integer "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_targets_on_player_id"
  end

  add_foreign_key "player_targets", "players"
  add_foreign_key "player_targets", "targets"
  add_foreign_key "switches", "players"
  add_foreign_key "targets", "players"
end
