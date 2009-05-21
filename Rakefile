require 'rake/testtask'
require 'rake/clean'

require 'spec/rake/spectask'


CLOBBER.include('dist')


task :default => [:spec, :dist]

desc 'Package the FlexUtils scripts as a single file'
task :dist => 'dist/flexutils.rb'

file 'dist/flexutils.rb' => ['lib/flexutils/FlexUtils.rb'] + FileList['lib/flexutils/*.rb'].exclude('lib/flexutils/FlexUtils.rb') do |t|
  mkdir_p 'dist'
  
  File.open(t.name, 'w') do |destination_file|
    destination_file.puts("module FlexUtils")
    
    t.prerequisites.each do |script|
      code = File.read(script)
      
      offset = code.index('module FlexUtils') + 16
      length = code.rindex('end') - offset
      
      code = code.slice(offset, length)
      
      destination_file.puts(code)
    end
    
    destination_file.puts("end")
  end
end

desc "Run the specifications"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files      = FileList['spec/*_spec.rb']
  t.libs            = [File.dirname(__FILE__) + '/lib']
  t.spec_opts       = ['--require', 'lib/flexutils', '--format', 'specdoc', '--color']
  t.fail_on_error   = true
  t.failure_message = 'Tests failed'
end