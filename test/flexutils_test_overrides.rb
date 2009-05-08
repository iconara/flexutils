module FlexUtils
  
  class AbstractTool

    def execute_command( command_str, options = { } )
      operative_options = standard_options.merge(options)
    
      @@last_command_str       = command_str
      @@last_operative_options = operative_options
      
      `echo -n` # this fakes a positive exit status
    end
  
    def self.last_command_str
      @@last_command_str
    end
  
    def self.last_operative_options
      @@last_operative_options
    end
    
  end

end