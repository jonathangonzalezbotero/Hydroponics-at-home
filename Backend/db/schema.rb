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

ActiveRecord::Schema.define(version: 0) do

  create_table "accounts", primary_key: "id_account", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Guarda informacion bancaria para recibir/pagar las ordenes de compra" do |t|
    t.integer "id_person", null: false
    t.string "type_ID", limit: 3, null: false
    t.string "type_account", limit: 45, comment: "Ahorro, Corriente, Credito"
    t.integer "number"
    t.string "name_bank", limit: 45
    t.index ["id_person", "type_ID"], name: "fk_Account_Person1_idx"
  end

  create_table "califications", primary_key: "id_calification", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Se registra el puntaje de cada compra hecha por el cliente" do |t|
    t.integer "id_order", null: false
    t.integer "score"
    t.string "comment", limit: 200
    t.index ["id_order"], name: "fk_Calificacion_Pedido1_idx"
  end

  create_table "categories", primary_key: "id_category", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Se indican las categorias de los productos hidroponicos" do |t|
    t.string "name", limit: 50
    t.string "description", limit: 500
  end

  create_table "clients", primary_key: "id_client", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "En esta tabla se registran las personas como clientes" do |t|
    t.integer "id_person", null: false
    t.string "type_ID", limit: 3, null: false
    t.string "kind_person", limit: 15, comment: "Juridica o Natrual"
    t.string "nit", limit: 20
    t.string "description", limit: 45
    t.string "url", limit: 45
    t.index ["id_person", "type_ID"], name: "fk_Client_Person1_idx"
  end

  create_table "cultivator_has_products", primary_key: "id_cultivator_has_products", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Esta tabla permite conocer cuales productos estan cultivando los cultivadores, ademas de saber su disponibilidad" do |t|
    t.integer "id_person", null: false
    t.string "type_ID", limit: 3, null: false
    t.integer "id_product", null: false
    t.integer "availability"
    t.date "update_date", comment: "Tabla para actualizar la disponibilidad de cada producto"
    t.index ["id_person", "type_ID"], name: "fk_Cultivator_has_Product_Cultivator1_idx"
    t.index ["id_product"], name: "fk_Cultivator_has_Product_Product1_idx"
  end

  create_table "cultivators", primary_key: "id_cultivator", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "En esta tabla se registran las personas como cultivadores" do |t|
    t.integer "id_person", null: false
    t.string "type_ID", limit: 3, null: false
    t.date "birth_day"
    t.string "gender", limit: 1
    t.index ["id_person", "type_ID"], name: "fk_Cultivator_Person1"
  end

  create_table "dispatches", primary_key: "id_dispatch", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "se guardan los datos de quien fue el encargado de atender la orden de compra" do |t|
    t.integer "id_person", null: false
    t.string "type_ID", limit: 3, null: false
    t.integer "id_order", null: false
    t.date "dispatch_date"
    t.index ["id_order"], name: "fk_Despacho_Pedido1_idx"
    t.index ["id_person", "type_ID"], name: "fk_Dispatch_Cultivator1_idx"
  end

  create_table "order_has_products", primary_key: "id_order_has_products", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Permite relacionar que productos solicito el usuario al momento de realizar su cotizacion" do |t|
    t.integer "id_product", null: false
    t.integer "id_order", null: false
    t.integer "quantity"
    t.decimal "unitPrice", precision: 20
    t.index ["id_order"], name: "fk_LineaCompra_Pedido1_idx"
    t.index ["id_product"], name: "fk_LineaCompra_Producto1_idx"
  end

  create_table "orders", primary_key: "id_order", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Tabla donde se guarda la solicitud de compra por parte del cliente" do |t|
    t.integer "id_person", null: false
    t.string "type_ID", limit: 3, null: false
    t.decimal "total", precision: 20
    t.date "application_date"
    t.index ["id_person", "type_ID"], name: "fk_Order_Client1_idx"
  end

  create_table "products", primary_key: "id_product", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Tabla maestra para los productos existentes en el sistema" do |t|
    t.integer "id_category", null: false
    t.string "name", limit: 50
    t.string "description", limit: 500
    t.decimal "price", precision: 10
    t.binary "image", limit: 4294967295
    t.index ["id_category"], name: "fk_Producto_Categoria1_idx"
  end

  create_table "users", primary_key: ["id_person", "type_ID"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Tabla maestra de personas" do |t|
    t.integer "id_person", null: false, auto_increment: true
    t.string "type_ID", limit: 3, null: false
    t.string "first_name", limit: 70
    t.string "last_name", limit: 45
    t.integer "telephone"
    t.string "address", limit: 50
    t.string "email", limit: 50
    t.string "username", limit: 50
    t.string "password", limit: 50
    t.binary "image", limit: 4294967295
    t.string "role", limit: 10, comment: "Consumidor o Cultivador"
  end

  add_foreign_key "accounts", "users", column: "id_person", primary_key: "id_person", name: "fk_Account_Person1"
  add_foreign_key "accounts", "users", column: "type_ID", primary_key: "type_ID", name: "fk_Account_Person1"
  add_foreign_key "califications", "orders", column: "id_order", primary_key: "id_order", name: "fk_Calificacion_Pedido1"
  add_foreign_key "clients", "users", column: "id_person", primary_key: "id_person", name: "fk_Client_Person1"
  add_foreign_key "clients", "users", column: "type_ID", primary_key: "type_ID", name: "fk_Client_Person1"
  add_foreign_key "cultivator_has_products", "cultivators", column: "id_person", primary_key: "id_person", name: "fk_Cultivator_has_Product_Cultivator1"
  add_foreign_key "cultivator_has_products", "cultivators", column: "type_ID", primary_key: "type_ID", name: "fk_Cultivator_has_Product_Cultivator1"
  add_foreign_key "cultivator_has_products", "products", column: "id_product", primary_key: "id_product", name: "fk_Cultivator_has_Product_Product1"
  add_foreign_key "cultivators", "users", column: "id_person", primary_key: "id_person", name: "fk_Cultivator_Person1"
  add_foreign_key "cultivators", "users", column: "type_ID", primary_key: "type_ID", name: "fk_Cultivator_Person1"
  add_foreign_key "dispatches", "cultivators", column: "id_person", primary_key: "id_person", name: "fk_Dispatch_Cultivator1"
  add_foreign_key "dispatches", "cultivators", column: "type_ID", primary_key: "type_ID", name: "fk_Dispatch_Cultivator1"
  add_foreign_key "dispatches", "orders", column: "id_order", primary_key: "id_order", name: "fk_Despacho_Pedido1"
  add_foreign_key "order_has_products", "orders", column: "id_order", primary_key: "id_order", name: "fk_LineaCompra_Pedido1"
  add_foreign_key "order_has_products", "products", column: "id_product", primary_key: "id_product", name: "fk_LineaCompra_Producto1"
  add_foreign_key "orders", "clients", column: "id_person", primary_key: "id_person", name: "fk_Order_Client1"
  add_foreign_key "orders", "clients", column: "type_ID", primary_key: "type_ID", name: "fk_Order_Client1"
  add_foreign_key "products", "categories", column: "id_category", primary_key: "id_category", name: "fk_Producto_Categoria1"
end
