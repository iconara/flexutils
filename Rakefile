task :default => :rba

desc 'Package the FlexUtils scripts as RBA'
task :rba => 'dist/flexutils.rb'

file 'dist/flexutils.rb' => FileList['lib/flexutils/*.rb'] do |t|
  mkdir_p 'dist'
  
  cp 'lib/flexutils.rb', 'lib/init.rb'
  
  sh "/usr/bin/tar2rubyscript lib #{t.name}"
  
  rm 'lib/init.rb'
end