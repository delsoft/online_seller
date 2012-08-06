module Mymodule
  #module Acts
    #module Idiot
      # this is called when the module is included into the 'base' module
      def self.included(base)
        # add all methods from the module "AddActsAsMethod" to the 'base' module
        base.extend AddWellFormatted
      end
     
     
      module AddWellFormatted
        def well_formatted(field, options={})
          # BELONGS_TO HAS_MANY GOES HERE
          method_name = "ensure_well_formatted_#{field.to_s.downcase}"          
          
          define_method "do_#{method_name}".to_sym do |fld, opts={}|
            
          end
          
          define_method method_name.to_sym do 
            block.call(method_name)
          end
          
          class_eval <<-END
            before_validation ":#{method_name}".to_sym                                                   
          END
        end
      end
      
      
      module InstanceMethods
        def self.included(aClass)
          aClass.extend ClassMethods
        end

        # PUT YOUR INSTANCE METHODS HERE
        def ensure_well_formatted
          "#{self}: I am an idiotic object. And I say '#{msg}'."
        end
        
        module ClassMethods
          # PUT YOUR CLASS METHODS HERE
          def idiot(msg)
          "#{self}: I am an idiotic class. And I say '#{msg}'."
          end
        end
      end
    #end
  #end
end

ActiveRecord::Base.send :include, YourSuperName::Acts::Idiot

# module MyModule
# 
  # extend ActiveSupport::Concern
# 
  # # mattr_accessor :foo
#   
    # def self.included(base)
# #      ActiveRecord::Base.include InstanceMethods      
      # # base << self 
        # # wf_fields = []
      # # end
      # #self.wf_fields = []
# # 
# #debugger
# # puts base.inspect
      # # class_eval do 
        # # attr_accessor :foo
# #         
        # # @@foo = []
# #         
      # # end
# # #     
    # # base.class.foo = []
   # end
# # 
# #all_fields = []
#   
  # def well_formatted(field, options = {})
#     
    # puts "hello from well formatted !!"
    # # InstanceMethods.foo << {:field => field,  :options =>  options}
    # # @@wf_fields << {:field => field,  :options =>  options}
    # #@@all_fields = [] unless @@all_fields == Array
   # #all_fields = [] unless all_fields and all_fields.class == Array
    # #puts @@all_fields.inspect
    # # foo << "from well_fromatted"
    # # puts foo.inspect
#    
    # #include InstanceMethods
  # end
#     
  # module InstanceMethods
    # # @@foo = []
    # # cattr_accessor :foo
#     
    # def ensure_well_formatted(field, options={})
      # puts "hello from ensure well formatted "      
      # #@all_fields << {:field => field,  :options =>  options}
      # # puts @@foo.inspect
    # end
  # end
#   
  # # def initialize
    # # @all_fields = []
  # # end
# #   
  # # def teste
    # # "123"
  # # end
# #  
  # # def teste2
    # # @all_fields.inspect
  # # end
# #  
#   
  # # def initialize(*args)
    # # super(args)
    # # @all_fields = []  
  # # end
#   
  # # def self.included(base)
    # # @base = base
    # # base.class_eval do
      # # #before_validation :ensure_well_formatted
       # # def well_formatted(field, options={})
         # # "well formatted?"
       # # end     
     # # end
    # # end
# #     
  # # end
# # 
# #   
  # # def ensure_well_formatted
    # # puts "well formatted ..."
    # # puts @all_fields.inspect
  # # end
# end
# 
# ActiveRecord::Base.include MyModule 


class TipoUnidadeMedida < ActiveRecord::Base
  attr_accessible :formato, :nome
  # rdebugger
  #require 'my_module'
  
  #include MyModule
  
  # def ateste
     # teste
  # end
  
  validate :cc
  
  before_validation :te
  
  well_formatted :nome
  
  has_one :nome
  
  #before_validation MyModule::hello_my_module
  
  validates :nome, :presence => true, :uniqueness => true
  validates :nome_abreviado, :presence => true, :uniqueness => true
  validates :formato, :presence => true
  
end

class Teste

  def din
    xx = "hello"
    add_method "do_#{xx}".to_sym do |fld, opts={}|
      
      puts fld.to_s
      puts opts.inspect
    end
    
    add_method xx do
      block.call("do_" + xx)
    end
    
  end
end
