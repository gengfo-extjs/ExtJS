#!/usr/local/ruby -w
# drb_hash_server.rb
require 'drb'

# Start up DRb with a URI and a hash to share
shared_hash = {:server => 'Some data set by the server' }
DRb.start_service('druby://127.0.0.1:61676', shared_hash)
puts 'Listening for connection...'
DRb.thread.join  # Wait on DRb thread to exit...
#---
require 'drb'

# Prep DRb
DRb.start_service
# Fetch the shared object
shared_data = DRbObject.new_with_uri('druby://127.0.0.1:61676')

# Add to the Hash
shared_data[:client] = 'Some data set by the client'
shared_data.each do |key, value|
  puts "#{key} => #{value}"
end
# client => Some data set by the client
# server => Some data set by the server
#---
# threadsafe_hash.rb
require 'rubygems'
require 'facet/basicobject'               # For the BasicObject class
require 'thread'                          # For the Mutex class

#---
# A thread-safe Hash that delegates all its methods to a real hash.
class ThreadsafeHash < BasicObject
  def initialize(*args, &block)
    @hash = Hash.new(*args, &block)  # The shared hash
    @lock = Mutex.new                # For thread safety
  end
  
  def method_missing(method, *args, &block)
    if @hash.respond_to? method  # Forward Hash method calls...
      @lock.synchronize do       # but wrap them in a thread safe lock.
        @hash.send(method, *args, &block)
      end
    else
      super
    end
  end
end
#---
#!/usr/bin/ruby -w
# threadsafe_hash_server.rb

require 'threadsafe_hash'  # both sides of DRb connection need all classes
require 'drb'
#---
$SAFE = 1  # Minimum acceptable paranoia level when sharing code!
#---
# Start up DRb with a URI and an object to share.
DRb.start_service('druby://127.0.0.1:61676', Threadsafe.new)
puts 'Listening for connection...'
DRb.thread.join  # wait on DRb thread to exit...
#---
#!/usr/bin/ruby
# threadsafe_hash_client.rb

require 'remote_hash'  # Both sides of DRb connection need all classes
require 'drb'

# Prep DRb
DRb.start_service

# Fetch the shared hash
$shared_data = DRbObject.new_with_uri('druby://127.0.0.1:61676')

puts 'Enter Ruby commands using the shared hash $shared_data...'
require 'irb'
IRB.start
#---
$ ruby threadsafe_hash_client.rb
Enter Ruby commands using the shared hash $shared_data...
irb(main):001:0> $shared_data.keys
=> []
irb(main):002:0> $shared_data[:terminal_one] = 'Hello other terminals!'
=> "Hello other terminals!"
#---
$ ruby threadsafe_hash_client.rb
Enter Ruby commands using the shared hash $shared_data...
irb(main):001:0> $shared_data.keys
=> [:terminal_one]
irb(main):002:0> $shared_data[:terminal_one]
=> "Hello other terminals!"
irb(main):003:0> $shared_data[:terminal_two] = 'Is this thing on?'
=> "Is this thing on?"
#---
irb(main):003:0> $shared_data.each_pair do |key, value|
irb(main):004:1*   puts "#{key} => #{value}"
irb(main):005:1> end
terminal_one => Hello other terminals!
terminal_two => Is this thing on?
#---
