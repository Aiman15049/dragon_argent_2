# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_07_144539) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "dynamic_pages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ancestry"
    t.integer "position"
    t.integer "asset_id"
    t.text "intro"
    t.text "meta_description"
    t.string "meta_title"
    t.integer "owner_id"
    t.string "owner_type"
    t.string "slug"
    t.string "static_descriptor"
    t.string "title"
    t.string "workflow_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ancestry"], name: "index_dynamic_pages_on_ancestry"
    t.index ["asset_id"], name: "index_dynamic_pages_on_asset_id"
    t.index ["meta_title"], name: "index_dynamic_pages_on_meta_title"
    t.index ["owner_id", "owner_type"], name: "owner"
    t.index ["owner_id"], name: "index_dynamic_pages_on_owner_id"
    t.index ["owner_type"], name: "index_dynamic_pages_on_owner_type"
    t.index ["position"], name: "index_dynamic_pages_on_position"
    t.index ["slug"], name: "index_dynamic_pages_on_slug"
    t.index ["static_descriptor"], name: "index_dynamic_pages_on_static_descriptor"
    t.index ["title"], name: "index_dynamic_pages_on_title"
    t.index ["workflow_state"], name: "index_dynamic_pages_on_workflow_state"
  end

end
