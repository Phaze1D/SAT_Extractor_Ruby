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

  create_table "comprobantes", force: :cascade do |t|
    t.integer "folio",             limit: 4,                                          null: false
    t.date    "fecha",                                                                null: false
    t.text    "sello",             limit: 65535,                                      null: false
    t.string  "formaDePago",       limit: 45
    t.string  "noCertificado",     limit: 45
    t.text    "certificado",       limit: 65535
    t.decimal "subTotal",                        precision: 15, scale: 2
    t.decimal "descuento",                       precision: 15, scale: 2
    t.integer "tipoCambio",        limit: 3
    t.string  "moneda",            limit: 45
    t.decimal "total",                           precision: 15, scale: 2
    t.string  "tipoDeComprobante", limit: 45
    t.text    "metodoDePago",      limit: 65535
    t.text    "lugarExpedicion",   limit: 65535
    t.integer "cancelado",         limit: 1,                              default: 0, null: false
    t.string  "serie",             limit: 45
    t.integer "emisor_id",         limit: 4,                                          null: false
    t.integer "receptor_id",       limit: 4,                                          null: false
  end

  add_index "comprobantes", ["emisor_id"], name: "fk_comprobantes_emisor_idx", using: :btree
  add_index "comprobantes", ["folio", "emisor_id", "serie"], name: "unique_folio_emisor", unique: true, using: :btree
  add_index "comprobantes", ["receptor_id"], name: "fk_comprobantes_receptor1_idx", using: :btree

  create_table "conceptos", force: :cascade do |t|
    t.integer "cantidad",       limit: 2,                           null: false
    t.string  "unidad",         limit: 45,                          null: false
    t.decimal "valorUnitario",             precision: 15, scale: 2, null: false
    t.decimal "importe",                   precision: 15, scale: 2, null: false
    t.integer "producto_id",    limit: 4,                           null: false
    t.integer "comprobante_id", limit: 4,                           null: false
  end

  add_index "conceptos", ["comprobante_id"], name: "fk_comprobante_id_idx", using: :btree
  add_index "conceptos", ["producto_id"], name: "fk_conceptos_products1_idx", using: :btree

  create_table "domicilios", force: :cascade do |t|
    t.string  "calle",        limit: 45
    t.string  "noExterior",   limit: 45
    t.string  "noInterior",   limit: 45
    t.string  "colonia",      limit: 45
    t.string  "localidad",    limit: 45
    t.string  "municipio",    limit: 45
    t.string  "estado",       limit: 45
    t.string  "pais",         limit: 45
    t.integer "codigoPostal", limit: 4,  null: false
    t.integer "receptor_id",  limit: 4
    t.integer "emisor_id",    limit: 4
  end

  add_index "domicilios", ["emisor_id"], name: "fk_domicilio_emisor1_idx", using: :btree
  add_index "domicilios", ["receptor_id"], name: "fk_domicilio_receptor1_idx", using: :btree

  create_table "emisors", force: :cascade do |t|
    t.string "rfc",    limit: 45,    null: false
    t.text   "nombre", limit: 65535, null: false
  end

  create_table "impuestos", force: :cascade do |t|
    t.decimal "totalImpuestosTrasladados",           precision: 15, scale: 2
    t.integer "comprobante_id",            limit: 4,                          null: false
  end

  add_index "impuestos", ["comprobante_id"], name: "comprobante_id_UNIQUE", unique: true, using: :btree
  add_index "impuestos", ["comprobante_id"], name: "fk_impuestos_comprobante1_idx", using: :btree

  create_table "informancion_aduaneras", force: :cascade do |t|
    t.string  "numero",      limit: 45,                 null: false
    t.date    "fecha",                                  null: false
    t.string  "aduana",      limit: 45, default: "GDL"
    t.integer "concepto_id", limit: 4,                  null: false
  end

  add_index "informancion_aduaneras", ["concepto_id"], name: "fk_informancion_aduaneras_concepto1_idx", using: :btree

  create_table "productos", force: :cascade do |t|
    t.string "PLU",         limit: 45
    t.text   "descripcion", limit: 65535
  end

  create_table "receptors", force: :cascade do |t|
    t.string "rfc",    limit: 45,    null: false
    t.text   "nombre", limit: 65535, null: false
  end

  create_table "timbre_fiscal_digitals", force: :cascade do |t|
    t.text    "selloCFD",         limit: 65535, null: false
    t.date    "fechaTimbrado",                  null: false
    t.string  "UUID",             limit: 45,    null: false
    t.string  "noCertificadoSAT", limit: 45,    null: false
    t.text    "selloSAT",         limit: 65535, null: false
    t.integer "comprobante_id",   limit: 4,     null: false
  end

  add_index "timbre_fiscal_digitals", ["comprobante_id"], name: "comprobante_id_UNIQUE", unique: true, using: :btree
  add_index "timbre_fiscal_digitals", ["comprobante_id"], name: "fk_timbre_fiscal_digitals_comprobante1_idx", using: :btree

  create_table "traslados", force: :cascade do |t|
    t.string  "impuesto_c",  limit: 45,                          null: false
    t.decimal "tasa",                   precision: 15, scale: 2
    t.decimal "importe",                precision: 15, scale: 2
    t.integer "impuesto_id", limit: 4,                           null: false
  end

  add_index "traslados", ["impuesto_id"], name: "fk_traslado_impuesto1_idx", using: :btree

  add_foreign_key "comprobantes", "emisors", name: "fk_comprobantes_emisor", on_delete: :cascade
  add_foreign_key "comprobantes", "receptors", name: "fk_comprobantes_receptor1"
  add_foreign_key "conceptos", "comprobantes", name: "fk_comprobante_id", on_delete: :cascade
  add_foreign_key "conceptos", "productos", name: "fk_conceptos_productos1"
  add_foreign_key "domicilios", "emisors", name: "fk_domicilio_emisor1"
  add_foreign_key "domicilios", "receptors", name: "fk_domicilio_receptor1"
  add_foreign_key "impuestos", "comprobantes", name: "fk_impuestos_comprobante1", on_delete: :cascade
  add_foreign_key "informancion_aduaneras", "conceptos", name: "fk_informancion_aduaneras_concepto1", on_delete: :cascade
  add_foreign_key "timbre_fiscal_digitals", "comprobantes", name: "fk_timbre_fiscal_digitals_comprobante1", on_delete: :cascade
  add_foreign_key "traslados", "impuestos", name: "fk_traslado_impuesto1", on_delete: :cascade
end
