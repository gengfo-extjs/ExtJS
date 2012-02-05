module Enumerable
  def each_simultaneously
    threads = []
    each { |e| threads << Thread.new { yield e } }
    return threads
  end
end
#---
start_time = Time.now
[7,8,9].each_simultaneously do |e|
   sleep(5) # Simulate a long, high-latency operation
   print "Completed operation for #{e}!\n"
end
# Completed operation for 8!
# Completed operation for 7!
# Completed operation for 9!
Time.now - start_time                 # => 5.009334
#---
require 'enumerator'

array = [7, 8, 9]
simultaneous_array = array.enum_for(:each_simultaneously)
simultaneous_array.each do |e|
  sleep(5) # Simulate a long, high-latency operation
  print "Completed operation for #{e}!\n"
end
# Completed operation for 7!
# Completed operation for 9!
# Completed operation for 8!
#---
simultaneous_array.collect { |x| sleep 5; x * -1 }            # => []
#---
[SSHServer, HTTPServer, IRCServer].each_simultaneously do |server| 
  server.serve_forever
end

# More code goes here...
#---
require 'enumerator'
module Enumerable
  def all_simultaneously
    if block_given?
      collect { |e| Thread.new { yield(e) } }.each { |t| t.join }
      self
    else
      enum_for :all_simultaneously
    end
  end
end
#---
array.all_simultaneously.collect { |x| sleep 5; x * -1 }
# => [-7, -9, -8]
#---
array.all_simultaneously.each_with_index { |x, i| sleep 5; puts "#{i}=>#{x}" }
# 0=>8
# 0=>7
# 0=>9
#---
module Enumerable
  def collect
    results = []
    each_with_index { |e, i| results[i] = yield(e) }
    results
  end

  def each_with_index
    i = -1
    each { |e| yield e, i += 1 }
  end
end
#---
array.all_simultaneously.collect { |x| sleep 5; x * -1 }
# => [-7, -8, -9]

array.all_simultaneously.each_with_index { |x, i| sleep 5; puts "#{i}=>#{x}" }
# 1=>8
# 0=>7
# 2=>9
#---
