require 'rake/testtask'
require 'rake/clean'

require 'spec/rake/spectask'


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

desc "Run the specifications"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/*_spec.rb']
  t.libs       = [File.dirname(__FILE__) + '/lib']
  t.spec_opts  = ['--require', 'lib/flexutils', '--format', 'specdoc', '--color']
end