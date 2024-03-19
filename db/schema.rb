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

ActiveRecord::Schema[7.1].define(version: 2024_03_19_012206) do
  create_table "birds", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_birds_on_name", unique: true
  end

  create_table "birds_nodes", force: :cascade do |t|
    t.integer "bird_id", null: false
    t.integer "node_id", null: false
    t.index ["bird_id"], name: "index_birds_nodes_on_bird_id"
    t.index ["node_id"], name: "index_birds_nodes_on_node_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.integer "parent_id"
    t.index ["parent_id"], name: "index_nodes_on_parent_id"
  end

  add_foreign_key "birds_nodes", "birds"
  add_foreign_key "birds_nodes", "nodes"
end
