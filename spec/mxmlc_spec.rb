describe FlexUtils::Mxmlc do
  
  before(:each) do
    @input  = 'src/Main.mxml'
    @output = 'build/Main.swf'
    
    @compiler = FlexUtils::Mxmlc.new(@output, @input)
    @compiler.theme_files                 = ['theme/common.css', 'theme/some/longer/path/to/a.swc']
    @compiler.allow_source_path_overlap   = true
    @compiler.keep_generated_actionscript = true
  end
  
  it_should_behave_like "any Asc-derived tool"
  
  it "should add the input file" do
    @compiler.command_string.should include(@input)
  end
  
  it "should set the output file and prefix it with -output" do
    @compiler.command_string.should include("-output #{@output}")
  end
  
  it "should set -allow-source-path-overlap" do
    @compiler.command_string.should include("-allow-source-path-overlap")
  end
  
  it "should not set -allow-source-path-overlap (when it is false)" do
    @compiler.allow_source_path_overlap = false;
    
    @compiler.command_string.should_not include("-allow-source-path-overlap")
  end
  
  it "should set -keep-generated-actionscript" do
    @compiler.command_string.should include("-keep-generated-actionscript")
  end
  
  it "should not set -keep-generated-actionscript (when it's false)" do
    @compiler.keep_generated_actionscript = false
    
    @compiler.command_string.should_not include("-keep-generated-actionscript")
  end
  
end