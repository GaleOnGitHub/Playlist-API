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

ActiveRecord::Schema.define(version: 20160416190041) do

  create_table "Album", primary_key: "AlbumId", force: :cascade do |t|
    t.string  "Title",    limit: 160, null: false
    t.integer "ArtistId",             null: false
  end

  add_index "Album", ["AlbumId"], name: "IPK_Album", unique: true
  add_index "Album", ["ArtistId"], name: "IFK_AlbumArtistId"

  create_table "Artist", primary_key: "ArtistId", force: :cascade do |t|
    t.string "Name", limit: 120
  end

  add_index "Artist", ["ArtistId"], name: "IPK_Artist", unique: true

  create_table "Customer", primary_key: "CustomerId", force: :cascade do |t|
    t.string  "FirstName",    limit: 40, null: false
    t.string  "LastName",     limit: 20, null: false
    t.string  "Company",      limit: 80
    t.string  "Address",      limit: 70
    t.string  "City",         limit: 40
    t.string  "State",        limit: 40
    t.string  "Country",      limit: 40
    t.string  "PostalCode",   limit: 10
    t.string  "Phone",        limit: 24
    t.string  "Fax",          limit: 24
    t.string  "Email",        limit: 60, null: false
    t.integer "SupportRepId"
  end

  add_index "Customer", ["CustomerId"], name: "IPK_Customer", unique: true
  add_index "Customer", ["SupportRepId"], name: "IFK_CustomerSupportRepId"

  create_table "Employee", primary_key: "EmployeeId", force: :cascade do |t|
    t.string   "LastName",   limit: 20, null: false
    t.string   "FirstName",  limit: 20, null: false
    t.string   "Title",      limit: 30
    t.integer  "ReportsTo"
    t.datetime "BirthDate"
    t.datetime "HireDate"
    t.string   "Address",    limit: 70
    t.string   "City",       limit: 40
    t.string   "State",      limit: 40
    t.string   "Country",    limit: 40
    t.string   "PostalCode", limit: 10
    t.string   "Phone",      limit: 24
    t.string   "Fax",        limit: 24
    t.string   "Email",      limit: 60
  end

  add_index "Employee", ["EmployeeId"], name: "IPK_Employee", unique: true
  add_index "Employee", ["ReportsTo"], name: "IFK_EmployeeReportsTo"

  create_table "Genre", primary_key: "GenreId", force: :cascade do |t|
    t.string "Name", limit: 120
  end

  add_index "Genre", ["GenreId"], name: "IPK_Genre", unique: true

  create_table "Invoice", primary_key: "InvoiceId", force: :cascade do |t|
    t.integer  "CustomerId",                                            null: false
    t.datetime "InvoiceDate",                                           null: false
    t.string   "BillingAddress",    limit: 70
    t.string   "BillingCity",       limit: 40
    t.string   "BillingState",      limit: 40
    t.string   "BillingCountry",    limit: 40
    t.string   "BillingPostalCode", limit: 10
    t.decimal  "Total",                        precision: 10, scale: 2, null: false
  end

  add_index "Invoice", ["CustomerId"], name: "IFK_InvoiceCustomerId"
  add_index "Invoice", ["InvoiceId"], name: "IPK_Invoice", unique: true

  create_table "InvoiceLine", primary_key: "InvoiceLineId", force: :cascade do |t|
    t.integer "InvoiceId",                          null: false
    t.integer "TrackId",                            null: false
    t.decimal "UnitPrice", precision: 10, scale: 2, null: false
    t.integer "Quantity",                           null: false
  end

  add_index "InvoiceLine", ["InvoiceId"], name: "IFK_InvoiceLineInvoiceId"
  add_index "InvoiceLine", ["InvoiceLineId"], name: "IPK_InvoiceLine", unique: true
  add_index "InvoiceLine", ["TrackId"], name: "IFK_InvoiceLineTrackId"

  create_table "MediaType", primary_key: "MediaTypeId", force: :cascade do |t|
    t.string "Name", limit: 120
  end

  add_index "MediaType", ["MediaTypeId"], name: "IPK_MediaType", unique: true

  create_table "Playlist", primary_key: "PlaylistId", force: :cascade do |t|
    t.string  "Name",      limit: 120
    t.integer "ApiKey_id"
  end

  add_index "Playlist", ["ApiKey_id"], name: "index_playlist_on_ApiKey_id"
  add_index "Playlist", ["PlaylistId"], name: "IPK_Playlist", unique: true

  create_table "PlaylistTrack", id: false, force: :cascade do |t|
    t.integer "PlaylistId", null: false
    t.integer "TrackId",    null: false
  end

  add_index "PlaylistTrack", ["PlaylistId", "TrackId"], name: "IPK_PlaylistTrack", unique: true
  add_index "PlaylistTrack", ["PlaylistId", "TrackId"], name: "sqlite_autoindex_PlaylistTrack_1", unique: true
  add_index "PlaylistTrack", ["TrackId"], name: "IFK_PlaylistTrackTrackId"

  create_table "Track", primary_key: "TrackId", force: :cascade do |t|
    t.string  "Name",         limit: 200,                          null: false
    t.integer "AlbumId"
    t.integer "MediaTypeId",                                       null: false
    t.integer "GenreId"
    t.string  "Composer",     limit: 220
    t.integer "Milliseconds",                                      null: false
    t.integer "Bytes"
    t.decimal "UnitPrice",                precision: 10, scale: 2, null: false
  end

  add_index "Track", ["AlbumId"], name: "IFK_TrackAlbumId"
  add_index "Track", ["GenreId"], name: "IFK_TrackGenreId"
  add_index "Track", ["MediaTypeId"], name: "IFK_TrackMediaTypeId"
  add_index "Track", ["TrackId"], name: "IPK_Track", unique: true

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
