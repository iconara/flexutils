module FlexUtils

  class TestRunner < Adl
  
    attr_writer :fail_on_error,
                :exit_on_complete

    def initialize( swf )
      super(swf)
    
      @fail_on_error    = true
      @exit_on_complete = false
    end
  
    def run!( extra_args=[], &block )
      log_file = "tests.log"
    
      super([log_file, "-exit-on-complete", @exit_on_complete]) do |res|
        if File.exist? log_file
          #File.read("data.txt")?
          output = File.open(log_file) { |f| f.read }
          
          rm log_file
        end
        
        if @fail_on_error
          if output.nil? 
            fail "No output from tests."
          elsif output =~ /tests failed/i 
            fail "Tests failed!"
          elsif res.nil? or res.exitstatus != 0
            fail "Test runner failed!"
          end
        end
      end
    end
  
  end

end