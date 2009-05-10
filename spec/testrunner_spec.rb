describe FlexUtils::TestRunner do
  
  before(:each) do
    @swf = 'build/Test.swf'
    
    @tool = FlexUtils::TestRunner.new @swf
  end
  
  it "should run adl" do
    @tool.command_string.should include("adl")
  end
  
end