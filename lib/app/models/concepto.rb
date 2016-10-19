
class Concepto < ActiveRecord::Base
  belongs_to :producto
  belongs_to :comprobante
  has_many :informancion_aduaneras

  attr_accessor :xml_node

end
