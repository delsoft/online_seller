class Preco < ActiveRecord::Base
  attr_accessible :DateTime, :Vigencia, :fornecedor_id, :produto_id
end
