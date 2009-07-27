module FlexUtils
  
  class AbstractTool
  
    def command_path( command_name )
      if ENV['FLEX_HOME']
        File.join(ENV['FLEX_HOME'], 'bin', command_name + command_extension)
      else
        command_name + command_extension
      end
    end

    def command_extension
      case RUBY_PLATFORM
        when /mswin/: '.exe'
        else: ''
      end
    end
    
    def command_string
      
    end
  
    def execute_command( options = { } )
      operative_options = standard_options.merge(options)
    
      cmd_str = command_string
    
      puts cmd_str if operative_options[:verbose]
    
      %x(#{cmd_str} 2>&1)
    end
  
    def standard_options
      {:verbose => true}
    end

  end
  
end
