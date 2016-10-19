
class Comprobante < ActiveRecord::Base
  has_one :impuesto
  has_one :timbre_fiscal_digital
  belongs_to :receptor
  belongs_to :emisor
  has_many :conceptos
end
