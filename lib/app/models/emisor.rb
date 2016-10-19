
class Emisor < ActiveRecord::Base
  has_many :comprobantes
  has_many :domicilios
end