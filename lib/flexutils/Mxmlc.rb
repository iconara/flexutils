module FlexUtils

  class Mxmlc < Asc

    attr_writer :theme_files,                # list of paths to theme SWC or CSS files
                :allow_source_path_overlap,  # boolean
                :keep_generated_actionscript # boolean

    def initialize( output, main_class )
      super(output)
      
      @main_class = main_class
    
      @keep_generated_actionscript = false
      @allow_source_path_overlap   = false
    
      @theme_files = []
    end
    
    def compiler_base_name
      "mxmlc"
    end

    def compiler_flags
      all_flags = super()
    
      all_flags << "-allow-source-path-overlap"   if @allow_source_path_overlap
      all_flags << "-keep-generated-actionscript" if @keep_generated_actionscript
    
      all_flags << "-output #{@output}"

      all_flags << "-theme #{@theme_files.join(' ')}" unless @theme_files.empty?
    
      all_flags << "--"
    
      all_flags << @main_class
    
      all_flags
    end
    
  end
  
end