module FlexUtils

  class Adl

    attr_writer :swf,
                :title,
                :visible,
                :transparent,
                :width,
                :height,
                :x,
                :y,
                :system_chrome,
                :arguments

    def initialize( swf )
      @swf           = swf
      @title         = "Temporary AIR application"
      @visible       = true
      @transparent   = false
      @width         = 1024
      @height        = 768
      @x             = 100
      @y             = 100
      @system_chrome = "standard"
      @arguments     = []
    end
  
    def generate_descriptor
      return <<-stop
<?xml version="1.0"?>
    
<application xmlns="http://ns.adobe.com/air/application/1.5">
	<id>net.iconara.tmp</id>
	<version>1.0</version>
	<filename>#{@title}</filename>
	<initialWindow>
		<title>#{@title}</title>
		<content>#{File.basename(@swf)}</content>
		<systemChrome>#{@system_chrome}</systemChrome>
	    <transparent>#{@transparent}</transparent>
	    <visible>#{@visible}</visible>
		<width>#{@width}</width> 
		<height>#{@height}</height>
    <x>#{@x}</x>
    <y>#{@y}</y>
	</initialWindow>
</application>
stop
    end
  
    def run!( extra_args=[], &block )
      currentDir = Dir.pwd
    
      dir = File.dirname(@swf)
    
      Dir.chdir(dir)
    
      descriptorName = "temporary-application.xml"
    
      descriptor = File.new(descriptorName, "w")
      descriptor.puts(generate_descriptor)
      descriptor.close
    
      args = (@arguments + extra_args).join(" ")
    
      command_string = "#{command_path 'adl'} #{descriptorName} -- #{args}"
      
      puts command_string
        
      `#{command_string}`
      
      yield($?) if block_given?
    
      File.delete(descriptorName)
    
      Dir.chdir(currentDir)
    end

  end
  
end