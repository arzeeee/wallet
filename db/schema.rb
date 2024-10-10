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

ActiveRecord::Schema[7.2].define(version: 2024_10_09_222823) do
  create_table "stock_transactions", force: :cascade do |t|
    t.integer "quantity", default: 0, null: false
    t.float "price", default: 0.0, null: false
    t.integer "transaction_type", null: false
    t.integer "stock_id", null: false
    t.integer "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_stock_transactions_on_stock_id"
    t.index ["wallet_id"], name: "index_stock_transactions_on_wallet_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "identifier", null: false
    t.float "change", null: false
    t.float "day_high", null: false
    t.float "day_low", null: false
    t.float "last_price", null: false
    t.string "symbol", null: false
    t.datetime "last_update_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_stocks_on_identifier", unique: true
  end

  create_table "user_transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.float "balance"
    t.string "transaction_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.float "balance", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "stock_transactions", "stocks"
  add_foreign_key "stock_transactions", "wallets"
  add_foreign_key "user_transactions", "users"
  add_foreign_key "wallets", "users"
end
