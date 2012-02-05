$ gem uninstall blinkenlights
Attempting to uninstall gem 'blinkenlights'
Successfully uninstalled cmdparse version 0.0.2
#---
require 'rubygems'
require 'rubygems/installer'
require 'rubygems/remote_installer'
Gem::RemoteInstaller.new.install('blinkenlights')

require 'rubygems/gem_runner'
require 'rubygems/doc_manager'
Gem.manage_gems
Gem::GemRunner.new.run(['uninstall', 'blinkenlights'])
# Successfully uninstalled blinkenlights version 0.0.4
#---
Gem::Uninstaller.new('actionpack', {}).uninstall
# You have requested to uninstall the gem:
#        actionpack-1.8.1
# actionmailer-0.9.1 depends on [actionpack (= 1.8.1)]
# If you remove this gem, the dependency will not be met.
# Uninstall anyway? [yN]
#---
