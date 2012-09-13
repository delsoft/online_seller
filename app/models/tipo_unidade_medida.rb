#ActiveRecord::Base.logger = Logger.new(STDOUT)


class TipoUnidadeMedida < ActiveRecord::Base
  attr_accessible :formato, :nome
    
  #well_formatted :nome, :right_just => { :lenght => 10, :char => '@' }   
    
  validates :nome, :presence => true, :uniqueness => true
  validates :nome_abreviado, :presence => true, :uniqueness => true
  validates :formato, :presence => true

 
 def track_block_depth(&block)
    @block_depth = 0 unless @block_depth
    @block_depth += 1
    yield
    ensure
     @block_depth -= 1
  end
  
  def method1(stuff, &block)
    track_block_depth do
      puts "This is #{stuff}... #{@block_depth} level deep\n"
      yield
    end
  end
  
  def method2(stuff, &block)
    track_block_depth do
      puts "This is #{stuff}... #{@block_depth} levels deep\n"
      yield
    end
  end
  
end

  