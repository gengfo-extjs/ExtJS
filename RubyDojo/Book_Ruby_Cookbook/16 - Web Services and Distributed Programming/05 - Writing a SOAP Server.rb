require 'soap/rpc/standaloneServer'

class MyServer < SOAP::RPC::StandaloneServer
  def initialize(*args)
    super
    add_method(self, 'sayhelloto', 'username')
  end
end
#---
class MyServer
  def sayhelloto(username)
    "Hello, #{username}."
  end
end
#---
server = MyServer.new('CoolServer','urn:mySoapServer','localhost',8888)
trap('INT') { server.shutdown }
server.start
#---
require 'soap/rpc/driver'
driver = SOAP::RPC::Driver.new('http://localhost:8888/', 'urn:mySoapServer')
driver.add_method('sayhelloto', 'username')
driver.sayhelloto('Kevin')                              # => "Hello, Kevin."
#---
