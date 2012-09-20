class GrupoProduto < ActiveRecord::Base
  attr_accessible :descricao, :integer, :nome, :parent_id
end
