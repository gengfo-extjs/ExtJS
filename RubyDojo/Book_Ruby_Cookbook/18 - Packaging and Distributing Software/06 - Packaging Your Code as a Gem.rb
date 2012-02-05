# shielding.gemspec
require 'rubygems'
spec = Gem::Specification.new do |spec|
  spec.name = 'shielding'
  spec.summary = 'A library for calculating the strength of duophasic shielding'
  spec.description = %{This library calculates to high precision the
  physical and electrostatic strength of a duophasic shield. It knows
  about most real-world shield configurations, as well as many
  theoretical arrangements not yet built.}
  spec.author = 'Bob Zaff'
  spec.email = 'zaff@example.com'
  spec.homepage = 'http://www.example.com/software/shielding/'
  spec.files = Dir['lib/*.rb']
  spec.version = '1.0.0'
end
#---
$ gem build shielding.gemspec
Attempting to build gem spec 'shielding.gemspec'
  Successfully built RubyGem
  Name: shielding
  Version: 1.0.0
  File: shielding-1.0.0.gem

$ ls
shield.gemspec  shielding-1.0.0.gem
#---
$ gem install ./shielding-1.0.0.gem
Attempting local installation of './shielding-1.0.0.gem'
Successfully installed shielding, version 1.0.0
Installing RDoc documentation for shielding-1.0.0...
WARNING: Generating RDoc on .gem that may not have RDoc.
#---
require 'rubygems/builder'
builder = Gem::Builder.new(spec).build
# Successfully built RubyGem
# Name: shielding
# Version: 1.0.0
# File: shielding-1.0.0.gem
# => "shielding-1.0.0.gem"
#---
spec.test_files = Dir['test/*.rb']
spec.extra_rdoc_files = ['README']
spec.files = Dir['lib/*.rb'] + spec.test_files + spec.extra_rdoc_files
#---
spec.add_dependency('another_gem')               #Any version will do.
spec.add_dependency('yet_another_gem', '~> 3.0') #Must be 3.0.x series.
#---
