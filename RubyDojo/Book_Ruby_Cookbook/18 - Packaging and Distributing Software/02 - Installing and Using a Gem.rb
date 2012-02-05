$ gem install RedCloth
Attempting local installation of 'RedCloth'
Local gem file not found: RedCloth*.gem
Attempting remote installation of 'RedCloth'
Successfully installed RedCloth-3.0.4
#---
# This code assumes the "cmdparse" gem has been installed, as in the
# code above.
require 'cmdparse'
# LoadError: no such file to load -- cmdparse

require 'rubygems'
require 'cmdparse'
parser = CmdParse::CommandParser.new
# ...
#---
$ ruby -e "require 'cmdparse'; puts 'Success'"
-e:1:in `require': no such file to load -- cmdparse (LoadError)
        from -e:1

$ ruby -rubygems -e "require 'cmdparse'; puts 'Success'"
Success

# On Unix:
$ export RUBYOPT=rubygems
$ ruby -e "require 'cmdparse'; puts 'Success'"
Success

# On Windows:
$ set RUBYOPT=rubygems
$ ruby -e "require 'cmdparse'; puts 'Success'"
Success
#---
$ gem update cmdparse
# Upgrading installed gems...
# Attempting remote upgrade of cmdparse
# Attempting remote installation of 'cmdparse'
# Successfully installed cmdparse-2.0.0
# Installing RDoc documentation for cmdparse-2.0.0...
# Gems: [cmdparse] updated
#---
$ gem install cmdparse-2.0.0
$ gem install cmdparse --version "2.0.0"
#---
$ ruby -e "require 'rubygems'; require_gem 'units', '~>1.0' puts 'Units'"
/usr/local/lib/site_ruby/1.8/rubygems.rb:204:in `report_activate_error': 
Could not find RubyGem units (~> 1.0) (Gem::LoadError)

$ gem install units --version "~> 1.0"
Attempting remote installation of 'units'
Successfully installed units-1.0.1
Installing RDoc documentation for units-1.0.1...

$ ruby -e "require 'rubygems'; require_gem 'units', '~>1.0'; puts 'Units'"
Units!
#---
$ gem install rubyful_soup --include-dependencies
Attempting local installation of 'rubyful_soup'
Local gem file not found: rubyful_soup*.gem
Attempting remote installation of 'rubyful_soup'
Successfully installed rubyful_soup-1.0.4
Successfully installed htmltools-1.09
Installing RDoc documentation for rubyful_soup-1.0.4...
Installing RDoc documentation for htmltools-1.09...
#---
require 'rubygems/installer'
require 'rubygems/remote_installer'

def install_gem(gem_name)
  if File.file? gem_name:
    Gem::Installer.new(gem_name).install
  else
    Gem::RemoteInstaller.new.install(gem_name)
  end
end

install_gem('cmdparse')
# Updating Gem source index for: http://gems.rubyforge.org
# => [#<Gem::Specification:0xb5fc7dbc 
#     @loaded_from="/usr/lib/ruby/gems/1.8/specifications/cmdparse-2.0.0.gemspec"]
# ...
#---
