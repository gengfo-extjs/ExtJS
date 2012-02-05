#!/usr/bin/ruby
# queue_server.rb

require 'thread'     # For Ruby's thread-safe Queue
require 'drb'

$SAFE = 1            # Minimum acceptable paranoia level when sharing code!

def run_queue(url='druby://127.0.0.1:61676')
  queue = Queue.new  # Containing the jobs to be processed

  # Start up DRb with URI and object to share
  DRb.start_service(url, queue)
  puts 'Listening for connection...'
  while job = queue.deq
    yield job
  end
end
#---
run_queue do |job|
  case job['request']
  when 'Report'
    puts "Reporting for #{job['from']}...  Done."
  when 'Process'
    puts "Processing for #{job['from']}..."
    sleep 3          # Simulate real work
    puts 'Processing complete.'
  end
end
#---
$ ruby queue_server.rb
Listening for connection...
Processing for Client 1...
Processing complete.
Processing for Client 2...
Processing complete.
Reporting for Client 1...  Done.
Reporting for Client 2...  Done.
Processing for Client 1...
Processing complete.
Reporting for Client 2...  Done.
...
#---
#!/usr/bin/ruby
# queue_client.rb

require 'thread'
require 'drb'

# Get a unique name for this client
NAME = ARGV.shift or raise "Usage:  #{File.basename($0)} CLIENT_NAME"

DRb.start_service
queue = DRbObject.new_with_uri("druby://127.0.0.1:61676")

20.times do
  queue.enq('request' => ['Report', 'Process'][rand(2)], 'from' => NAME)
  sleep 1  # simulating network delays
end
#---
