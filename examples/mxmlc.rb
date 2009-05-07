require 'flexutils'

Mxmlc.compile(t.name, 'src/Main.mxml') do |conf|
  conf.debug           = true
  conf.incremental     = true
  conf.theme_files     = FileList['theme/*.css']
  conf.locale          = ['en_US', 'sv_SE']
  conf.source_path     = ['src', 'locale/{locale}', 'theme']
  conf.library_path    = ['lib']
  conf.warnings        = {'show-unused-type-selector-warnings' => false}
  conf.target_player   = '10'
  conf.fail_on_warning = true
end