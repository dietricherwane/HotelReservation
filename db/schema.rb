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

ActiveRecord::Schema.define(version: 20141226165613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_bed_types", force: true do |t|
    t.string   "name",       limit: 100
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bed_types", force: true do |t|
    t.string   "name",       limit: 100
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name",       limit: 100
    t.integer  "country_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name",       limit: 45
    t.string   "code",       limit: 3
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: true do |t|
    t.string   "name",        limit: 100
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hotel_id"
  end

  create_table "hotels", force: true do |t|
    t.string   "name",                 limit: 100
    t.integer  "stars"
    t.string   "address",              limit: 100
    t.string   "longitude",            limit: 50
    t.string   "latitude",             limit: 50
    t.string   "phone_number",         limit: 20
    t.string   "mobile_number",        limit: 20
    t.string   "email",                limit: 100
    t.string   "website",              limit: 100
    t.text     "description"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "location_description"
    t.text     "rooms_description"
    t.text     "terms"
    t.integer  "city_id"
    t.string   "front_file_name"
    t.string   "front_content_type"
    t.integer  "front_file_size"
    t.datetime "front_updated_at"
    t.integer  "user_id"
    t.string   "authorization_number", limit: 100
  end

  create_table "miscs", force: true do |t|
    t.string   "description",       limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.boolean  "published"
  end

  create_table "pictures", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "room_details", force: true do |t|
    t.string   "name",       limit: 100
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_type_additional_beds", force: true do |t|
    t.integer  "room_type_id"
    t.integer  "additional_bed_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

  create_table "room_type_details", force: true do |t|
    t.integer  "room_detail_id"
    t.integer  "room_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_type_variation_miscs", force: true do |t|
    t.integer  "room_type_variation_id"
    t.integer  "misc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_type_variations", force: true do |t|
    t.integer  "room_type_id"
    t.boolean  "cancellable"
    t.integer  "cancellation_delay"
    t.text     "cancellation_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_types", force: true do |t|
    t.string   "name",                 limit: 100
    t.integer  "bed_type_id"
    t.text     "description"
    t.integer  "number_of_persons"
    t.integer  "available_rooms"
    t.float    "price"
    t.boolean  "cancellable"
    t.integer  "cancellation_delay"
    t.string   "cancellation_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
    t.integer  "hotel_id"
  end

  create_table "room_variation_prices", force: true do |t|
    t.integer  "room_type_id"
    t.float    "price"
    t.integer  "room_type_variation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specification_types", force: true do |t|
    t.string   "name",       limit: 100
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specifications", force: true do |t|
    t.string   "name",                  limit: 100
    t.integer  "specification_type_id"
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hotel_id"
  end

  create_table "sub_specifications", force: true do |t|
    t.string   "description",      limit: 100
    t.integer  "specification_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
