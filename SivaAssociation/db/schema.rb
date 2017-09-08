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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20170201104302) do

  create_table "hobbies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "showings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "movie_id"
    t.integer  "theatre_id"
  end

  create_table "showtimes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "movie_id"
    t.integer  "theatre_id"
  end

  create_table "sstudentdetails", :force => true do |t|
    t.string   "address"
    t.string   "father_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sstudents", :force => true do |t|
    t.string   "name"
    t.integer  "roll_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sstudent_id"
  end

  create_table "students", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teaching_assistants", :force => true do |t|
    t.string   "name"
    t.integer  "ta_duty_id"
    t.string   "ta_duty_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theatres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end