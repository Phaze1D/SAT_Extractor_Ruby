
class Impuesto < ActiveRecord::Base
  belongs_to :comprobante
  has_many :traslados
end
