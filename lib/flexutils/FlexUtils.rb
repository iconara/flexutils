module FlexUtils
  
  def command_path( command_name )
    if ENV['FLEX_HOME'].nil?
      return command_name
    else
      File.join(ENV['FLEX_HOME'], 'bin', command_name)
    end
  end
  
end