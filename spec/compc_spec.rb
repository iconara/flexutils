describe FlexUtils::Compc do
  
  before(:each) do
    @output = 'build/Main.swf'
    
    @compiler = FlexUtils::Compc.new(@output)
    # :manifest,        # hash manifest_file => namespace_uri
    # :include_classes, # list
    # :include_sources, # list
    # :include_files    # hash file_name => file_path
  end
  
  it_should_behave_like "any Asc-derived tool"

end