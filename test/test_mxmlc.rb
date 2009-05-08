$: << File.dirname(__FILE__) + '/../lib'


require 'test/unit'
require 'flexutils'

require File.dirname(__FILE__) + '/flexutils_test_overrides'

include FlexUtils


class TextMxmlc < Test::Unit::TestCase
  # def setup
  # end

  # def teardown
  # end

  def test_command_str_should_contain_mxmlc
    Mxmlc.compile('output.swf', 'input.mxml') { |conf| }
    
    assert_match(/mxmlc/, Mxmlc.last_command_str, 'The command string did not include the compiler')
  end
  
  def test_command_str_should_contain_output_file
    Mxmlc.compile('output.swf', 'input.mxml') { |conf| }
    
    assert_match(/-output\s+output\.swf/, Mxmlc.last_command_str, 'The command string did not include the -output switch, or the argument was wrong')
  end
  
  def test_command_str_should_contain_input_file
    Mxmlc.compile('output.swf', 'input.mxml') { |conf| }
    
    assert_match(/--\s+input\.mxml\s*$/, Mxmlc.last_command_str, 'The command string did not end with -- and the main source file')
  end
  
  def test_command_str_should_contain_theme_switch_and_theme_files
    Mxmlc.compile('output.swf', 'input.mxml') do |conf|
      conf.theme_files = ['theme/common.css', 'theme/some/other/path/theme.swc']
    end
    
    assert_match(/-theme/, Mxmlc.last_command_str, 'The command string did not include -theme switch')
    assert_match(/theme\/common.css/, Mxmlc.last_command_str, 'The command string did not include the first theme file')
    assert_match(/theme\/.+?\/theme.swc/, Mxmlc.last_command_str, 'The command string did not include the second theme file')
  end
  
  def test_command_str_should_contain_allow_source_path_overlap
    Mxmlc.compile('output.swf', 'input.mxml') { |conf| }
    
    assert_no_match(/allow-source-path-overlap/, Mxmlc.last_command_str, 'The command string should not contain allow-source-path-overlap unless it\'s been explicitly set to true')

    Mxmlc.compile('output.swf', 'input.mxml') do |conf|
      conf.allow_source_path_overlap = false
    end
    
    assert_no_match(/allow-source-path-overlap/, Mxmlc.last_command_str, 'The command string should not contain allow-source-path-overlap unless it\'s been explicitly set to true')
    
    Mxmlc.compile('output.swf', 'input.mxml') do |conf|
      conf.allow_source_path_overlap = true
    end
    
    assert_match(/-allow-source-path-overlap/, Mxmlc.last_command_str, 'The command string should contain -allow-source-path-overlap when it\'s been set to true') 
  end
  
  def test_command_str_should_contain_keep_generated_actionscript
    Mxmlc.compile('output.swf', 'input.mxml') { |conf| }
    
    assert_no_match(/keep-generated-actionscript/, Mxmlc.last_command_str, 'The command string should not contain keep-generated-actionscript unless it\'s been explicitly set to true')

    Mxmlc.compile('output.swf', 'input.mxml') do |conf|
      conf.keep_generated_actionscript = false
    end
    
    assert_no_match(/keep-generated-actionscript/, Mxmlc.last_command_str, 'The command string should not contain keep-generated-actionscript unless it\'s been explicitly set to true')
    
    Mxmlc.compile('output.swf', 'input.mxml') do |conf|
      conf.keep_generated_actionscript = true
    end
    
    assert_match(/-keep-generated-actionscript/, Mxmlc.last_command_str, 'The command string should contain -keep-generated-actionscript when it\'s been set to true') 
  end
  
end