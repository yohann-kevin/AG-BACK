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

ActiveRecord::Schema.define(version: 2023_06_01_171524) do

  create_table "administrators", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "agents", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password"
    t.boolean "cgu"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "article_pictures", force: :cascade do |t|
    t.string "article_id"
    t.string "picture_path"
    t.boolean "main_picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cloudinary_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "event_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "destinator"
    t.string "sender"
    t.string "object"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone"
    t.string "company"
    t.string "activity"
    t.string "need"
  end

  create_table "model_infos", force: :cascade do |t|
    t.string "model_uuid"
    t.integer "size"
    t.integer "weight"
    t.integer "chest"
    t.integer "waist"
    t.integer "hips"
    t.integer "shoe_size"
    t.string "color"
    t.string "hair_color"
    t.string "astrological"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "eyes"
  end

  create_table "model_networks", force: :cascade do |t|
    t.string "model_uuid"
    t.string "instagram"
    t.string "facebook"
    t.string "snapchat"
    t.string "tiktok"
    t.string "twitter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "model_pictures", force: :cascade do |t|
    t.string "model_uuid"
    t.string "picture_path"
    t.boolean "main_picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cloudinary_id"
  end

  create_table "models", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.datetime "birth_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sexe"
    t.string "level", default: "T7"
  end

  create_table "renew_passwords", force: :cascade do |t|
    t.string "agent_id"
    t.string "secure_id"
    t.string "agent_email"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
