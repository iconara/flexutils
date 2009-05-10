module FlexUtils

  class Asc < AbstractTool

    attr_writer :output,                # output file path
                :source_path,           # list
                :library_path,          # list
                :external_library_path, # list
                :locale,                # list of locales
                :debug,                 # boolean, default false
                :optimize,              # boolean, default true
                :strict,                # boolean, default true
                :verbose_stacktraces,   # boolean, default true
                :use_network,           # boolean, default true
                :incremental,           # boolean, default false
                :target_player,         # string, default "9.0.0"
                :defines,               # hash name => value
                :keep_as3_metadata,     # list of metadata names
                :warnings,              # hash warning_name => boolean (warning_name example "show-actionscript-warnings")
                :fail_on_error,         # boolean, default true
                :fail_on_warning        # boolean, default false
              
    def initialize( output )
      @output = output
    
      @debug               = false
      @optimize            = true
      @strict              = true
      @verbose_stacktraces = true
      @incremental         = false
      
      @target_player = "9.0.0"
    
      @source_path           = []
      @library_path          = []
      @external_library_path = []
      @locale                = []
      @keep_as3_metadata     = []
    
      @defines  = Hash.new
      @warnings = Hash.new
      
      @fail_on_error  = true
      @fail_on_warning = false
    
      self.compiler = "flex"
    end
    
    def compiler_base_name
      ""
    end
    
    def self.compile( *args ) 
      c = self.new(*args)
      
      yield c
      
      c.compile!
    end
  
    def compiler=( name )
      if name.to_s == "air"
        @configname = "air"
        @compiler   = "a" + compiler_base_name
      else
        @configname = "flex"
        @compiler   = compiler_base_name
      end
      
      @compiler = command_path @compiler
    end
  
    def defines_str
      defines = @defines.keys.map do |item|
        value = if @defines[item] =~ /\s/
          "'#{@defines[item]}'"
        else
          @defines[item]
        end
        
        "-define+=#{item},#{value}"
      end
      
      defines.join(' ')
    end
  
    def compiler_flags
      all_flags = []
    
      all_flags << ("+configname=" + @configname)
    
      all_flags << "-source-path+=#{@source_path.join(",")}"                     unless @source_path.empty?
      all_flags << "-library-path+=#{@library_path.join(",")}"                   unless @library_path.empty?
      all_flags << "-external-library-path+=#{@external_library_path.join(",")}" unless @external_library_path.empty?
      all_flags << "-locale=#{@locale.join(",")}"                                unless @locale.empty?
      all_flags << "-keep-as3-metadata=#{@keep_as3_metadata.join(",")}"          unless @keep_as3_metadata.empty?

      all_flags << "-debug"               if @debug
      all_flags << "-strict"              if @strict
      all_flags << "-optimize"            if @optimize
      all_flags << "-verbose-stacktraces" if @verbose_stacktraces
      all_flags << "-use-network"         if @use_network
      all_flags << "-incremental"         if @incremental
      
      all_flags << "-target-player #{@target_player}"

      all_flags << (@warnings.keys.map { |item| "-#{item}=#{@warnings[item]}" }.join(" "))

      all_flags << defines_str
      
      all_flags
    end
  
    def command_string
      all_flags = compiler_flags.delete_if { |item| (item.nil? || item =~ /^\s*$/) }.join(" ")
      
      "#{@compiler} #{all_flags}"
    end
    
    def compile!
      output = execute_command
      
      if block_given?
        yield($?, output)
      else
        puts output
      end
      
      if @fail_on_error and ($?.exitstatus != 0 or output.include? "Error:")
        fail "Compilation failed because of an error, see output above"
      end
         
      if @fail_on_warning and output.include? "Warning:"
        fail "Compilation failed because of a warning, see output above"
      end
    end

  end
  
end