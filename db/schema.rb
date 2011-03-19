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

ActiveRecord::Schema.define(:version => 20110319202639) do

  create_table "alerts", :force => true do |t|
    t.text     "news"
    t.string   "link"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

  create_table "contact_informations", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cellphone"
    t.string   "phone"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.integer  "fundation_id"
    t.integer  "provider_id"
  end

  create_table "event_admins", :force => true do |t|
    t.integer  "member_id"
    t.integer  "event_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "events", :force => true do |t|
    t.datetime "date"
    t.string   "name"
    t.integer  "fundation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "city"
    t.string   "place"
  end

  create_table "events_facilitators", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "facilitator_id"
  end

  create_table "events_fundations", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "fundation_id"
  end

  create_table "events_providers", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "provider_id"
  end

  create_table "events_shows", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "show_id"
  end

  create_table "facilitator_populations", :id => false, :force => true do |t|
    t.integer "population_id"
    t.integer "facilitator_id"
  end

  create_table "facilitators", :force => true do |t|
    t.text     "contribution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.string   "name"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "city"
  end

  create_table "facilitators_facilitators", :id => false, :force => true do |t|
    t.integer "facilitator_id"
    t.integer "followed_id"
  end

  create_table "feedbacks", :force => true do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fundation_admins", :force => true do |t|
    t.integer  "member_id"
    t.integer  "fundation_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "e_mail"
  end

  create_table "fundations", :force => true do |t|
    t.string   "address"
    t.string   "cellphone"
    t.string   "city"
    t.string   "country"
    t.text     "description"
    t.string   "phone"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "population_id"
    t.integer  "member_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "fundations_facilitators", :id => false, :force => true do |t|
    t.integer "fundation_id"
    t.integer "facilitator_id"
  end

  create_table "members", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",   :limit => 128
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "facebook_id"
    t.boolean  "use_facebook_pic",                    :default => false
    t.boolean  "admin",                               :default => false
  end

  create_table "photos", :force => true do |t|
    t.string   "path"
    t.string   "thumb"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "populations", :force => true do |t|
    t.string   "name_es"
    t.text     "description_es"
    t.integer  "age_min"
    t.integer  "age_max"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_en"
    t.string   "description_en"
  end

  create_table "provider_admins", :force => true do |t|
    t.integer  "member_id"
    t.integer  "provider_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "city"
  end

  create_table "providers_facilitators", :id => false, :force => true do |t|
    t.integer "provider_id"
    t.integer "facilitator_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", :force => true do |t|
    t.string   "costs"
    t.string   "description"
    t.string   "infrastructure"
    t.string   "offering"
    t.string   "requirements"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "population_id"
  end

end
