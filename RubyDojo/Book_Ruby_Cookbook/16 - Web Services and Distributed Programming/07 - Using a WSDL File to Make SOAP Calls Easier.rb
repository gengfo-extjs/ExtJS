require 'soap/wsdlDriver'
wsdl = 'http://services.xmethods.net/soap/urn:xmethods-delayed-quotes.wsdl'
driver = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver

puts "Stock price: %.2f" % driver.getQuote('TR')
# Stock price: 28.78
#---
require 'soap/wsdlDriver'
wsdl = 'http://api.google.com/GoogleSearch.wsdl'
driver = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
#---
my_google_key = 'get yours from https://www.google.com/accounts'
my_query = 'WSDL Ruby'
XSD::Charset.encoding = 'UTF8'
result = driver.doGoogleSearch(my_google_key, my_query, 0, 10, false, 
                               '', false, '', '', '')
#---
result.class
# => SOAP::Mapping::Object

(result.methods - SOAP::Mapping::Object.instance_methods).sort
# => ["directoryCategories", "directoryCategories=", "documentFiltering",
#     ...
#     "searchTips", "searchTips=", "startIndex", "startIndex="]
#---
"Query for: #{my_query}"
# => "Query for: WSDL Ruby"
"Found: #{result['estimatedTotalResultsCount']}"
# => "Found: 159000"
"Query took about %.2f seconds" % result['searchTime']
# => "Query took about 0.05 seconds"

result["resultElements"].each do |rec|
  puts "Title: #{rec["title"]}"
  puts "URL: #{rec["URL"]}"
  puts "Snippet: #{rec["snippet"]}"
  puts
end
# Title: <b>wsdl</b>: <b>Ruby</b> Standard Library Documentation
# URL: http://www.ruby-doc.org/stdlib/libdoc/wsdl/rdoc/index.html
# Snippet: #<SOAP::Mapping::Object:0xb705f560>
# 
# Title: how to make SOAP4R read <b>WSDL</b> files?
# URL: http://www.ruby-talk.org/cgi-bin/scat.rb/ruby/ruby-talk/37623
# Snippet: Subject: how to make SOAP4R read <b>WSDL</b> files? <b>...</b>
# ...
#---
