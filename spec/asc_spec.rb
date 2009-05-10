shared_examples_for "any Asc-derived tool" do
  
  it "should set the config name (default)" do
    @compiler.command_string.should include("+configname=flex")
  end
  
  it "should set tge config name (AIR)" do
    @compiler.compiler = :air
    
    @compiler.command_string.should include("+configname=air")
  end
  
  it "should set -source-path" do
    @compiler.source_path = ['src', 'theme', 'locale/{locale}']
    
    @compiler.command_string.should include('-source-path+=src,theme,locale/{locale}')
  end
  
  it "should set -library-path" do
    @compiler.library_path = ['lib', 'some/other/path']
    
    @compiler.command_string.should include('-library-path+=lib,some/other/path')
  end
  
  it "should set -external-library-path" do
    @compiler.external_library_path = ['/path/to/flex']
    
    @compiler.command_string.should include('-external-library-path+=/path/to/flex')
  end
  
  it "should set -locale" do
    @compiler.locale = ['en_US', 'sv_SE']
    
    @compiler.command_string.should include('-locale=en_US,sv_SE')
  end
  
  it "should not set -locale (when there's no locales specified)" do
    @compiler.command_string.should_not include('-locale')
  end
  
  it "should set -debug" do
    @compiler.debug = true
    
    @compiler.command_string.should include('-debug')
  end
  
  it "should not set -debug (when it's false)" do
    @compiler.debug = false
    
    @compiler.command_string.should_not include('-debug')
  end
  
  it "should set -optimize" do
    @compiler.optimize = true
    
    @compiler.command_string.should include('-optimize')
  end
  
  it "should not set -optimize (when it's false)" do
    @compiler.optimize = false
    
    @compiler.command_string.should_not include('-optimize')
  end
  
  it "should set -strict" do
    @compiler.strict = true
    
    @compiler.command_string.should include('-strict')
  end
  
  it "should not set -strict (when it's false)" do
    @compiler.strict = false
    
    @compiler.command_string.should_not include('-strict')
  end
  
  it "should set -verbose-stacktraces" do
    @compiler.verbose_stacktraces = true
    
    @compiler.command_string.should include('-verbose-stacktraces')
  end
  
  it "should not set -verbose-stacktraces (when it's false)" do
    @compiler.verbose_stacktraces = false
    
    @compiler.command_string.should_not include('-verbose-stacktraces')
  end

  it "should set -use-network" do
    @compiler.use_network = true
    
    @compiler.command_string.should include('-use-network')
  end
  
  it "should not set -use-network (when it's false)" do
    @compiler.use_network = false
    
    @compiler.command_string.should_not include('-use-network')
  end
  
  it "should set -incremental" do
    @compiler.incremental = true
    
    @compiler.command_string.should include('-incremental')
  end
  
  it "should not set -incremental (when it's false)" do
    @compiler.incremental = false
    
    @compiler.command_string.should_not include('-incremental')
  end
  
  it "should set -target-player to the right string" do
    @compiler.target_player = 'X.Y.Z'
    
    @compiler.command_string.should include('-target-player X.Y.Z')
  end
  
  it "should default to 9.0.0 for -target-player" do
    @compiler.target_player = '9.0.0'
    
    @compiler.command_string.should include("-target-player 9.0.0")
  end
  
  it "should set -keep-as3-metadata" do
    @compiler.keep_as3_metadata = ['one', 'two']
    
    @compiler.command_string.should include("-keep-as3-metadata=one,two")
  end
  
  it "should not set -keep-as3-metadata (when there's none specified)" do
    @compiler.command_string.should_not include("-keep-as3-metadata")
  end
  
  it "should set warning flags" do
    @compiler.warnings = {'show-actionscript-warnings' => true, 'some-other-warning' => false}
    
    @compiler.command_string.should include("-show-actionscript-warnings=true")
    @compiler.command_string.should include("-some-other-warning=false")
  end

  it "should set defines" do
    @compiler.defines = {'MY_NS' => false, 'SOME_OTHER_STRING' => 'some value'}
    
    @compiler.command_string.should include('-define+=MY_NS,false')
    @compiler.command_string.should include('-define+=SOME_OTHER_STRING,\'some value\'')
  end

  it "should not set any defined by default" do
    @compiler.command_string.should_not include("-define=")
  end
  
end