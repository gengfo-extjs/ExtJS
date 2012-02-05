require 'rubygems'
require 'cmdparse'                                         # => true
#---
require_gem 'nosuchgem'
# Gem::LoadError: Could not find RubyGem nosuchgem (> 0.0.0)
#---
require_gem 'cmdparse', '>= 1.0'                          # => false
require_gem 'cmdparse', '>= 2.0.3'
# Gem::LoadError: RubyGem version error: cmdparse(2.0.0 not >= 2.0.3)
#---
require_gem 'gem_1' '= 1.0.1'
require_gem 'gem_2' '= 2.6'
require_gem 'gem_3' '= 1.3.2'
#---
require_gem 'buggy' '!=1.0.3'
#---
require_gem 'my_gem' '>= 2.0'
require_gem 'my_gem' '< 3'
#---
