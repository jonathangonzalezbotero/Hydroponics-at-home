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

  create_table "calificacion", primary_key: ["idCalificacion", "Pedido_idPedido"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idCalificacion", null: false
    t.integer "Puntaje"
    t.string "Comentario", limit: 200
    t.integer "Pedido_idPedido", null: false
    t.index ["Pedido_idPedido"], name: "fk_Calificacion_Pedido1_idx"
  end

  create_table "categoria", primary_key: "CategoriaId", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "NombreCategoria", limit: 50
    t.string "Descripcion", limit: 500
  end

  create_table "cliente", primary_key: ["TipoId", "IdUsuario"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "TipoId", limit: 3, null: false
    t.integer "IdUsuario", null: false
    t.string "TipoPersona", limit: 15, comment: "Juridica o Natrual"
    t.string "Nit", limit: 20
    t.string "Descripcion", limit: 45
    t.string "Url", limit: 45
    t.index ["TipoId", "IdUsuario"], name: "fk_Consumidor_Usuario1_idx"
  end

  create_table "cuenta", primary_key: ["idCuenta", "TipoId", "IdUsuario"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Información bancaria para realizar/recibir el pago de los pedidos" do |t|
    t.string "idCuenta", limit: 45, null: false
    t.string "TipoCuenta", limit: 45, comment: "Ahorro, Corriente, Credito"
    t.integer "NumeroCuenta"
    t.string "NombreBanco", limit: 45
    t.string "TipoId", limit: 3, null: false
    t.integer "IdUsuario", null: false
    t.index ["TipoId", "IdUsuario"], name: "fk_Cuenta_Usuario1_idx"
  end

  create_table "cultivador", primary_key: ["TipoId", "IdUsuario"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "TipoId", limit: 3, null: false
    t.integer "IdUsuario", null: false
    t.date "FechaNacimiento"
    t.string "Genero", limit: 1
    t.index ["TipoId", "IdUsuario"], name: "fk_Cultivador_Usuario1_idx"
  end

  create_table "cultivador_has_producto", primary_key: ["Cultivador_TipoId", "Cultivador_IdUsuario", "Producto_ProductoId"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Cultivador_TipoId", limit: 3, null: false
    t.integer "Cultivador_IdUsuario", null: false
    t.integer "Producto_ProductoId", null: false
    t.integer "Disponibilidad"
    t.date "FechaActualizacion"
    t.index ["Cultivador_TipoId", "Cultivador_IdUsuario"], name: "fk_Cultivador_has_Producto_Cultivador1_idx"
    t.index ["Producto_ProductoId"], name: "fk_Cultivador_has_Producto_Producto1_idx"
  end

  create_table "despacho", primary_key: ["Pedido_idPedido", "Cultivador_TipoId", "Cultivador_IdUsuario"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "Pedido_idPedido", null: false
    t.string "Cultivador_TipoId", limit: 3, null: false
    t.integer "Cultivador_IdUsuario", null: false
    t.date "FechaEntrega"
    t.index ["Cultivador_TipoId", "Cultivador_IdUsuario"], name: "fk_Despacho_Cultivador1_idx"
    t.index ["Pedido_idPedido"], name: "fk_Despacho_Pedido1_idx"
  end

  create_table "lineacompra", primary_key: ["Producto_ProductoId", "Pedido_idPedido"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "Cantidad"
    t.decimal "Preciounitario", precision: 20
    t.integer "Producto_ProductoId", null: false
    t.integer "Pedido_idPedido", null: false
    t.index ["Pedido_idPedido"], name: "fk_LineaCompra_Pedido1_idx"
    t.index ["Producto_ProductoId"], name: "fk_LineaCompra_Producto1_idx"
  end

  create_table "pedido", primary_key: ["idPedido", "Cliente_TipoId", "Cliente_IdUsuario"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idPedido", null: false
    t.decimal "Total", precision: 20
    t.date "FechaSolicitud"
    t.string "Cliente_TipoId", limit: 3, null: false
    t.integer "Cliente_IdUsuario", null: false
    t.index ["Cliente_TipoId", "Cliente_IdUsuario"], name: "fk_Pedido_Cliente1_idx"
  end

  create_table "producto", primary_key: ["ProductoId", "Categoria_CategoriaId"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "ProductoId", null: false
    t.string "Nombre", limit: 50
    t.string "Descripcion", limit: 500
    t.decimal "Precio", precision: 10
    t.binary "Imagen", limit: 4294967295
    t.integer "Categoria_CategoriaId", null: false
    t.index ["Categoria_CategoriaId"], name: "fk_Producto_Categoria1_idx"
  end

  create_table "usuario", primary_key: ["TipoId", "IdUsuario"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "TipoId", limit: 3, null: false
    t.integer "IdUsuario", null: false
    t.string "Nombre", limit: 70
    t.string "Apellidos", limit: 45
    t.integer "Telefono"
    t.string "Direccion", limit: 50
    t.string "CorreoElectronico", limit: 50
    t.string "NombreUsuario", limit: 50
    t.string "Contraseña", limit: 50
    t.binary "Imagen", limit: 4294967295
    t.string "Rol", limit: 10, comment: "Consumidor o Cultivador"
  end

  add_foreign_key "calificacion", "pedido", column: "Pedido_idPedido", primary_key: "idPedido", name: "fk_Calificacion_Pedido1"
  add_foreign_key "cliente", "usuario", column: "IdUsuario", primary_key: "IdUsuario", name: "fk_Consumidor_Usuario1"
  add_foreign_key "cliente", "usuario", column: "TipoId", primary_key: "TipoId", name: "fk_Consumidor_Usuario1"
  add_foreign_key "cuenta", "usuario", column: "IdUsuario", primary_key: "IdUsuario", name: "fk_Cuenta_Usuario1"
  add_foreign_key "cuenta", "usuario", column: "TipoId", primary_key: "TipoId", name: "fk_Cuenta_Usuario1"
  add_foreign_key "cultivador", "usuario", column: "IdUsuario", primary_key: "IdUsuario", name: "fk_Cultivador_Usuario1"
  add_foreign_key "cultivador", "usuario", column: "TipoId", primary_key: "TipoId", name: "fk_Cultivador_Usuario1"
  add_foreign_key "cultivador_has_producto", "cultivador", column: "Cultivador_IdUsuario", primary_key: "IdUsuario", name: "fk_Cultivador_has_Producto_Cultivador1"
  add_foreign_key "cultivador_has_producto", "cultivador", column: "Cultivador_TipoId", primary_key: "TipoId", name: "fk_Cultivador_has_Producto_Cultivador1"
  add_foreign_key "cultivador_has_producto", "producto", column: "Producto_ProductoId", primary_key: "ProductoId", name: "fk_Cultivador_has_Producto_Producto1"
  add_foreign_key "despacho", "cultivador", column: "Cultivador_IdUsuario", primary_key: "IdUsuario", name: "fk_Despacho_Cultivador1"
  add_foreign_key "despacho", "cultivador", column: "Cultivador_TipoId", primary_key: "TipoId", name: "fk_Despacho_Cultivador1"
  add_foreign_key "despacho", "pedido", column: "Pedido_idPedido", primary_key: "idPedido", name: "fk_Despacho_Pedido1"
  add_foreign_key "lineacompra", "pedido", column: "Pedido_idPedido", primary_key: "idPedido", name: "fk_LineaCompra_Pedido1"
  add_foreign_key "lineacompra", "producto", column: "Producto_ProductoId", primary_key: "ProductoId", name: "fk_LineaCompra_Producto1"
  add_foreign_key "pedido", "cliente", column: "Cliente_IdUsuario", primary_key: "IdUsuario", name: "fk_Pedido_Cliente1"
  add_foreign_key "pedido", "cliente", column: "Cliente_TipoId", primary_key: "TipoId", name: "fk_Pedido_Cliente1"
  add_foreign_key "producto", "categoria", column: "Categoria_CategoriaId", primary_key: "CategoriaId", name: "fk_Producto_Categoria1"
end
