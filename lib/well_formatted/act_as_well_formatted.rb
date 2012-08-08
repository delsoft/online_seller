module Telelistas
  module WellFormatted

      def self.included(base_class)
        base_class.extend ClassMethods
        
        base_class.class_eval do
          before_validation ensure_well_formatted
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
end


ActiveRecord::Base.send :include, Telelistas::WellFormatted
