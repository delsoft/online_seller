#ActiveRecord::Base.logger = Logger.new(STDOUT)


class TipoUnidadeMedida < ActiveRecord::Base
  attr_accessible :formato, :nome
  
  well_formatted :nome, :right_just => { :lenght => 10, :char => '@' }   
    
  validates :nome, :presence => true, :uniqueness => true
  validates :nome_abreviado, :presence => true, :uniqueness => true
  validates :formato, :presence => true
  
end


