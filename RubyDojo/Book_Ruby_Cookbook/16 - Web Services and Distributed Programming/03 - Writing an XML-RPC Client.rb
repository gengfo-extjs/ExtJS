require 'xmlrpc/client'
server = XMLRPC::Client.new2('http://betty.userland.com/RPC2')
server.call('examples.getStateName', 5)               # => "California"
#---
begin
  server.call('noSuchMethod')
rescue XMLRPC::FaultException => e
  puts "Error: fault code #{e.faultCode}"
  puts e.faultString
end
# Error: fault code 7
# Can't evaluate the expression because the name "noSuchMethod" hasn't been defined.
#---
def lookup_upc(upc)
  server = XMLRPC::Client.new2('http://www.upcdatabase.com/rpc')
  begin
    response = server.call('lookupUPC', upc)   
    return response['found'] ? response : nil
  rescue XMLRPC::FaultException => e
    puts "Error: "
    puts e.faultCode
    puts e.faultString
  end
end

product = lookup_upc('018787765654')
product['description']                # => "Dr Bronner's Peppermint Oil Soap"
product['size']                       # => "128 fl oz"

lookup_upc('no such UPC')             # => nil
#---
