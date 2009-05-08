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
    
    def package!
      current_dir = Dir.pwd
    
      dir = File.dirname(@descriptor)
      
      Dir.chdir(dir)
      
      descriptor = File.basename(@descriptor)
      name       = File.basename(@name).gsub(/\.air$/, '')
      keyfile    = @keyfile.gsub(dir + '/', '')
      files      = (@files || []).map { |f| f.gsub(dir + '/', '') }.join(' ')

      command_string = "#{command_path 'adt'} -package -storetype pkcs12 -keystore #{keyfile} -storepass #{@keypass} #{name} #{descriptor} #{files}"
      
      execute_command command_string
      
      Dir.chdir(current_dir)
    end

  end
  
end