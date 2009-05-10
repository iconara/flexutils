describe FlexUtils::Adt do
  
  before(:each) do
    @descriptor = "src/Main-app.xml"
    @keyfile    = "src/Main-cert.p12"
    @keypass    = "secret"
    @name       = "Main"
    @files      = []
    
    @tool = FlexUtils::Adt.new
    @tool.descriptor = @descriptor
    @tool.keyfile    = @keyfile
    @tool.keypass    = @keypass
    @tool.name       = @name
    @tool.files      = @files
  end
  
  it "should run adt" do
    @tool.command_string.should include("adt")
  end
  
end