module FlexUtils

  class Compc < Asc

    attr_writer :manifest,        # hash manifest_file => namespace_uri
                :include_classes, # list
                :include_sources, # list
                :include_files    # hash file_name => file_path

    def initialize( output )
      super(output)
      
      @include_classes = []
      @include_sources = []

      @manifest        = Hash.new
      @include_files   = Hash.new
    end
    
    def compiler_base_name
      "compc"
    end
    
    def Compc.to_class_list( files, source_root )
      classes = files.map do |file|
        file.gsub(source_root, "").gsub(/\..+?$/, "").gsub(/\//, ".")
      end
    end
  
    def compiler_flags
      all_flags = super()
    
      all_flags << "-include-classes #{@include_classes.join(" ")}" unless @include_classes.empty?
      all_flags << "-include-sources #{@include_sources.join(" ")}" unless @include_sources.empty?
    
      all_flags << "-output #{@output}"

      all_flags << "-theme #{@theme}" unless @theme.nil?
    
      all_flags
    end
    
  end
  
end