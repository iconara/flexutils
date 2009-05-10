module FlexUtils
  
  class AbstractTool
  
    def command_path( command_name )
      if ENV['FLEX_HOME'].nil?
        return command_name
      else
        File.join(ENV['FLEX_HOME'], 'bin', command_name)
      end
    end
    
    def command_string
      
    end
  
    def execute_command( options = { } )
      operative_options = standard_options.merge(options)
    
      puts command_str if operative_options[:verbose]
    
      %x(#{command_str} 2>&1)
    end
  
    def standard_options
      {:verbose => true}
    end

  end
  
end