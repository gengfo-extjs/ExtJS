require 'soap/rpc/driver'
driver = SOAP::RPC::Driver.new(
            'http://webservices.codingtheweb.com/bin/qotd',
            'urn:xmethods-qotd')
#---
driver.add_method('getQuote')

puts driver.getQuote
# The holy passion of Friendship is of so sweet and steady and 
# loyal and enduring a nature that it will last through a whole 
# lifetime, if not asked to lend money.
# Mark Twain (1835 - 1910)
#---
require 'soap/rpc/driver'
driver = SOAP::RPC::Driver.new(
   'http://services.xmethods.net/soap/',      # The endpoint url
   'urn:xmethods-delayed-quotes')             # The namespace
#---
driver.add_method('getQuote', 'symbol')
#---
puts 'Stock price: %.2f' % driver.getQuote('TR')
# Stock price: 28.78
#---
