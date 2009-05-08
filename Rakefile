require 'rake/testtask'
require 'rake/clean'


CLOBBER.include('dist')


task :default => [:test, :rba]

desc 'Package the FlexUtils scripts as RBA'
task :rba => 'dist/flexutils.rb'

file 'dist/flexutils.rb' => FileList['lib/flexutils/*.rb'] do |t|
  mkdir_p 'dist'
  
  cp 'lib/flexutils.rb', 'lib/init.rb'
  
  sh "/usr/bin/tar2rubyscript lib #{t.name}"
  
  rm 'lib/init.rb'
end

desc "Run all the tests"
Rake::TestTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/test_*.rb']
    t.verbose = false
end