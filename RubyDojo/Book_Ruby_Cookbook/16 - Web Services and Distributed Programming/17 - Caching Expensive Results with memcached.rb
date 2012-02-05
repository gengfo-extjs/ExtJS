require 'rubygems'
require 'memcache'

class DataLayer

  def initialize(*cache_servers)
    @cache = MemCache.new(*cache_servers)
  end

  def get(key)
    @cache[key] ||= expensive_get(key)
  end
 alias_method :[], :get

  protected
  def expensive_get(key)
    # ...do expensive fetch of data for 'key'
    puts "Fetching expensive value for #{key}"
    key.to_s.reverse
  end
end
#---
layer = DataLayer.new( 'localhost:11211' )

3.times do
  puts "Data for 'foo': #{layer['foo']}"
end
# Fetching expensive value for foo
# Data for 'foo': oof
# Data for 'foo': oof
# Data for 'foo': oof
#---
class MyDataLayer
  def get(key)
    puts "Getting value for #{key} from data layer"
    return key.to_s.reverse
  end
end
#---
layer = MyDataLayer.new

"Value for 'foo': #{layer.get('foo')}"
# Getting value for foo from data layer
# => "Value for 'foo': oof"

"Value for 'foo': #{layer.get('foo')}"
# Getting value for foo from data layer
# => "Value for 'foo': oof"

"Value for 'foo': #{layer.get('foo')}"
# Getting value for foo from data layer
# => "Value for 'foo': oof"
#---
require 'memcache'

module GetSetMemcaching
  SERVER = 'localhost:11211'
  
  def self::extended(mod)
    mod.module_eval do
      alias_method :__uncached_get, :get
      remove_method :get

      def get(key)
        puts "Cached get of #{key.inspect}"
	get_cache()[key] ||= __uncached_get(key)
      end

      def get_cache
        puts "Fetching cache object for #{SERVER}"
        @cache ||= MemCache.new(SERVER)
      end
    end
    super
  end

  def self::included(mod)
    mod.extend(self)
    super
  end
end
#---
# Mix in caching to the pre-existing class
MyDataLayer.extend(GetSetMemcaching)

"Value for 'foo': #{layer.get('foo')}"
# Cached get of "foo"
# Fetching cache object for localhost:11211
# Getting value for foo from data layer
# => "Value for 'foo': oof"

"Value for 'foo': #{layer.get('foo')}"
# Cached get of "foo"
# Fetching cache object for localhost:11211
# => "Value for 'foo': oof"

"Value for 'foo': #{layer.get('foo')}"
# Cached get of "foo"
# Fetching cache object for localhost:11211
# => "Value for 'foo': oof"
#---
