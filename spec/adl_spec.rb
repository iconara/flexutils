describe FlexUtils::Adl do
  
  before(:each) do
    @swf = 'build/Main.swf'
    
    @tool = FlexUtils::Adl.new @swf
  end
  
  it "should run adl" do
    @tool.command_string.should include("adl")
  end
  
end