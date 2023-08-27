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

ActiveRecord::Schema[7.0].define(version: 2023_08_25_173955) do
  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "papers", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_papers_on_slug", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.integer "paper_id", null: false
    t.integer "correct_option", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "choice1"
    t.text "choice2"
    t.text "choice3"
    t.text "choice4"
    t.index ["paper_id"], name: "index_questions_on_paper_id"
  end

  create_table "responses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.text "choice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_responses_on_question_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "paper_id", null: false
    t.integer "user_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_question_count"
    t.index ["paper_id"], name: "index_scores_on_paper_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 0
    t.boolean "allowed", default: false
  end

  add_foreign_key "questions", "papers"
  add_foreign_key "responses", "questions"
  add_foreign_key "responses", "users"
  add_foreign_key "scores", "papers"
  add_foreign_key "scores", "users"
end
