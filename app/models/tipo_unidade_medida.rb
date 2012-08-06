 ActiveRecord::Base.logger = Logger.new(STDOUT)

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
          logger.debug "invoke_well_formatted => " + field.to_s
          logger.debug "    options => " + options.inspect
          #puts self.class.fields_to_be_formatted.inspect
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
  
  well_formatted :nome, :www => 'www', :tttt => 'rrrr'
  well_formatted :tste
  
    
  validates :nome, :presence => true, :uniqueness => true
  validates :nome_abreviado, :presence => true, :uniqueness => true
  validates :formato, :presence => true
  
end


