module FlexUtils

  class Adt < AbstractTool
    
    attr_writer :descriptor,
                :keyfile,
                :keypass,
                :name,
                :files
                
    def initialize
      @files = []
    end
    
    def self.app_version( descriptor_path )
      require 'rexml/document'

      doc = REXML::Document.new(File.new(descriptor_path))

      version_xpath = '/application/version/text()'

      REXML::XPath.first(doc, version_xpath).to_s
    end
    
    def self.package
      c = self.new
      
      yield c
      
      c.package!
    end
    
    def command_string
      unless @keyfile && @keypass && @name && @descriptor && @files
        raise ArgumentError, 'Missing arguments'
      end

      command    = command_path 'adt'
      keyfile    = @keyfile.gsub(File.dirname(@descriptor) + '/', '')
      descriptor = File.basename(@descriptor)
      name       = File.basename(@name).gsub(/\.air$/, '')
      files      = (@files || []).map { |f| f.gsub(dir + '/', '') }.join(' ')
        
      "#{command} -package -storetype pkcs12 -keystore #{keyfile} -storepass #{@keypass} #{name} #{descriptor} #{files}"
    end
    
    def package!
      current_dir = Dir.pwd
    
      dir = File.dirname(@descriptor)
      
      Dir.chdir(dir)
      
      puts execute_command
      
      Dir.chdir(current_dir)
    end

  end
  
end
