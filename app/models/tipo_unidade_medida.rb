#ActiveRecord::Base.logger = Logger.new(STDOUT)

  module MyModule

      def self.included(base_class)
        base_class.extend ClassMethods
        
        base_class.class_eval do
          before_validation :ensure_well_formatted
        end
      end
               
      module ClassMethods
                  
         @@fields_to_be_formatted ||= {}         

        def fields_to_be_formatted
           @@fields_to_be_formatted 
        end
         
        def well_formatted field_name, options={}                   
          @@fields_to_be_formatted[self.name.to_sym] ||= []  
          @@fields_to_be_formatted[self.name.to_sym] << { :attribute => field_name.to_sym, :options => options }          
        end
      end

protected      
  
      def invoke_well_formatted field, options={}

        raise "coluna '#{field.to_s}' inexistente\n verifique o comando \"#{self.class.name}.well_formated :#{field.to_s}\" " unless self.class.column_names.include?(field.to_s)
         
        return unless send(field.to_s) && send(field.to_s + "_changed?") 
        
        tmp = send(field.to_s).to_s.squish
    
        has_just = options.keys[ options.keys.index(:left_just) || options.keys.index(:right_just) || 999 ]
        if has_just then
          just_method = has_just.to_s[0] + "just"  
          just_len = options[has_just][:lenght] || value.lenght
          just_char = options[has_just][:char] || "0"
          tmp = tmp.send just_method, just_len, just_char
        end
        
        if options[:with] == :downcase || options[:downcase] then
          tmp = tmp.downcase
        elsif options[:with] == :upcase || options[:upcase] then
          tmp = tmp.upcase
        elsif options[:with]  == :blank_only || options[:blank_only] then
          //none
        else
          tmp = tmp.capitalize
        end

        send field.to_s + '=',  tmp

      end
      
      def ensure_well_formatted
        
        fields = self.class.fields_to_be_formatted[self.class.name.to_sym] || []
         
        fields.each do |field|
          
          invoke_well_formatted field[:attribute], field[:options] 
          
        end
        
      end
  end

ActiveRecord::Base.send :include, MyModule

class TipoUnidadeMedida < ActiveRecord::Base
  attr_accessible :formato, :nome
  
  extend Forwardable
  
  well_formatted :nome, :right_just => { :lenght => 10, :char => '@' }   
    
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

#========================================================

  class Stack
    extend Forwardable
    
    def initialize
      @stack = []
    end
    
    def_delegators :@stack, :push, :pop
    def_delegator :@stack, :length, :size
    
    def first
      @stack.last
    end
    
    def range(array=[])
      array.each {|item| push item }
    end
    
  end
    
  module BusinessLogic
    def initialize
        @stack = Stack.new
      @pos = 0
      @fatos = {}
    end
    
    def indent num, cursor, name
       ret = "|"
       num.times { ret += "  " }
       ret += cursor + name.to_s
       ret 
    end
    
    def contexto descr, &block
      @pos += 1
      puts indent(@pos, '>', descr)
      block.call
      @pos -= 1      
    end
      
    def fato descr, &block
      @fatos[@pos.to_sym] = []
      @pos += 1
      puts indent(@pos, ':', descr)
      block.call
      @pos -= 1      
    end
    
    def assercao sts, msg="fail"      
        @fatos[@pos.to_sym] << [sts,msg] unless sts       
    end
    
    def assertiva arg        
       
      s = [:debito_cliente, :tem_credito]
      a = arg.split(/ /)
      ret = []
      a.each do |word|
          if self.respond_to?(word)
            ret << self.send(word).to_s
          else
            ret << word
          end          
      end
      ret = ret.join " "
      puts ret
      instance_eval ret
    end
    
    def debito_cliente
      true
    end
    
    def tem_credito
      false
    end
    
  end


  class Teste
    include BusinessLogic
    def foo
      contexto "c1" do
        contexto "c2" do
          
        end
        contexto "c3" do
          
        end
      end
      
      contexto "c4" do
        
      end
      
    end
  end
