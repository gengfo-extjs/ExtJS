#!/usr/bin/ruby
# rinda_server.rb

require 'rinda/ring'        # for RingServer
require 'rinda/tuplespace'  # for TupleSpace

DRb.start_service

# Create a TupleSpace to hold named services, and start running.
Rinda::RingServer.new(Rinda::TupleSpace.new)

DRb.thread.join
#---
#!/usr/bin/ruby
# share_a_tuplespace.rb

require 'rinda/ring'        # for RingFinger and SimpleRenewer
require 'rinda/tuplespace'  # for TupleSpace

DRb.start_service
ring_server = Rinda::RingFinger.primary

# Register our TupleSpace service with the RingServer
ring_server.write( [:name, :TupleSpace, Rinda::TupleSpace.new, 'Tuple Space'],
                   Rinda::SimpleRenewer.new )

DRb.thread.join
#---
#!/usr/bin/ruby
# use_a_tuplespace.rb

require 'rinda/ring'        # for RingFinger
require 'rinda/tuplespace'  # for TupleSpaceProxy

DRb.start_service
ring_server = Rinda::RingFinger.primary

# Ask the RingServer for the advertised TupleSpace.
ts_service = ring_server.read([:name, :TupleSpace, nil, nil])[2]
tuplespace = Rinda::TupleSpaceProxy.new(ts_service)

# Now we can use the object normally:
tuplespace.write([:data, rand(100)])
puts "Data is #{tuplespace.read([:data, nil]).last}."
# Data is 91.
#---
