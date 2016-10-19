
class Domicilio < ActiveRecord::Base
  belongs_to :receptor
  belongs_to :emisor
end