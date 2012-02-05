$ gem query
*** LOCAL GEMS ***

sources (0.0.1)
   This package provides download sources for remote gem installation

$ gem query --remote
*** REMOTE GEMS ***
actionmailer (1.1.1, 1.0.1, 1.0.0, 0.9.1, 0.9.0, 0.8.1, ...)
    Service layer for easy email delivery and testing.

actionpack (1.10.1, 1.9.1, 1.9.0, 1.8.1, 1.8.0, 1.7.0, ...)
    Web-flow and rendering framework putting the VC in MVC.
 
[... Much more output omitted ....]
#---
require 'rubygems'

Gem::cache.each do |name, gem|  
  puts %{"#{gem.name}" gem version #{gem.version} is installed.}
end
# "sources" gem version 0.0.1 is installed.
#---
require 'rubygems/remote_installer'
require 'yaml'

def format_gems(gems)
  gem_versions = gems.inject({}) { |h, gem| (h[gem.name] ||= []) << gem; h}
  gem_versions.keys.sort.each do |name|
   versions = gem_versions[name].collect { |gem| gem.version.to_s }
    puts "#{name} is available in these versions: #{versions.join(', ')}"
  end
end
#---
format_gems(Gem::RemoteInstaller.new.search(/.*/).flatten)
# Asami is available in these versions: 0.04
# Bangkok is available in these versions: 0.1.0
# Bloglines4R is available in these versions: 0.1.0
# BlueCloth is available in these versions: 0.0.2, 0.0.3, 0.0.4, 1.0.0
# ...
#---
$ gem query --remote --name-matches "test"
** REMOTE GEMS ***

lazytest (0.1.0)
    Testing and benchmarking for lazy people

test-unit-mock (0.30)
    Test::Unit::Mock is a class for conveniently building mock objects
    in Test::Unit test cases.

testunitxml (0.1.4, 0.1.3)
    Unit test suite for XML documents

ZenTest (3.1.0, 3.0.0)
    == FEATURES/PROBLEMS
#---
format_gems(Gem::RemoteInstaller.new.search(/test/i).flatten)
# ZenTest is available in these versions: 3.0.0, 3.1.0
# lazytest is available in these versions: 0.1.0
# test-unit-mock is available in these versions: 0.30
# testunitxml is available in these versions: 0.1.3, 0.1.4
#---
require 'date'

def gems_newer_than(date, query=/.*/)
  time = Time.local(date.year, date.month, date.day, 0, 0, 0)
  gems = Gem::RemoteInstaller.new.search(query).flatten
  gems.reject do |gem| 
    gem_date = gem.date
    gem_date = DateTime.parse(gem_date) if gem_date.respond_to? :to_str
    gem_date < (gem_date.is_a?(Date) ? date : time)
  end
end

todays_gems = gems_newer_than(Date.today-1) 
todays_gems.size                                          # => 7
format_gems(todays_gems)
# filament is available in these versions: 0.3.0
# mechanize is available in these versions: 0.4.1
# mongrel is available in these versions: 0.3.12.1, 0.3.12.1
# rake is available in these versions: 0.7.1
# rspec is available in these versions: 0.5.0
# tzinfo is available in these versions: 0.2.0
#---
Gem::RemoteInstaller.new.sources            # => ["http://gems.rubyforge.org"]
#---
$ gem_server &

$ gem query --remote --source http://localhost:8808
# *** REMOTE GEMS ***
# Updating Gem source index for: http://localhost:8808
# sources (0.0.1)
#    This package provides download sources for remote gem installation
#---
Gem.sources.replace(['http://localhost:8808'])
format_gems(Gem::RemoteInstaller.new.search(/.*/).flatten)
# sources is available in these versions: 0.0.1
#---
