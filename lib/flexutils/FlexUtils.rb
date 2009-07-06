module FlexUtils
  
  class AbstractTool
  
    def command_path( command_name )
      if RUBY_PLATFORM =~ /mswin/
        ext = '.exe'
      else
        ext = ''
      end
      
      if ENV['FLEX_HOME'].nil?
        return command_name + ext
      else
        File.join(ENV['FLEX_HOME'], 'bin', command_name + ext)
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