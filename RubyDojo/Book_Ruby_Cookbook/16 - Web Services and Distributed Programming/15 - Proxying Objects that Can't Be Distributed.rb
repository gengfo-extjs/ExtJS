DRb.start_service  # The client needs to be a DRb service too.
#---
class MyLocalClass
  include DRbUndumped  # The magic line.  All objects of this type are proxied.
  # ...
end

# ... OR ...

my_local_object.extend DRbUndumped  # Proxy just this object.
#---
#!/usr/bin/ruby
# hello_server.rb
require 'drb'

# a simple greeter class
class HelloService
  def hello(in_stream, out_stream)
    out_stream.puts 'What is your name?'
    name = in_stream.gets.strip
    out_stream.puts "Hello #{name}."
  end
end

# start up DRb with URI and object to share
DRb.start_service('druby://localhost:61676', HelloService.new)
DRb.thread.join  # wait on DRb thread to exit...
#---
#!/usr/bin/ruby
# hello_client.rb
require 'drb'

# fetch service object and ask it to greet us...
hello_service = DRbObject.new_with_uri('druby://localhost:61676')
hello_service.hello($stdin, $stdout)
#---
#!/usr/bin/ruby
# hello_client2.rb
require 'drb'

DRb.start_service  # make sure client can serve proxy objects...
# and request that the streams be proxied
$stdin.extend  DRbUndumped
$stdout.extend DRbUndumped

# fetch service object and ask it to greet us...
hello_service = DRbObject.new_with_uri('druby://localhost:61676')
hello_service.hello($stdin, $stdout)
#---
