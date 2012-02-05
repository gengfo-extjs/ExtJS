require 'rubygems'
require 'memcache'

MC = MemCache.new '10.0.1.201'

MC[:test] = 'This string lives in memcached!'
#---
require 'rubygems'
require 'memcache'

MC = MemCache.new '10.0.1.201'

MC[:test]                               # => "This string lives in memcached!"
#---
hash = {
  :roses   => 'are red',
  :violets => 'are blue'
}

MC[:my_hash] = hash
MC[:my_hash][:roses]                    # => "are red"
#---
$ memcached -d -m 1024
#---
