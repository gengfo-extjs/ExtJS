require 'open-uri'
puts open('http://www.oreilly.com/').read(200)
# <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
#         "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
# <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
#---
require 'net/http'
response = Net::HTTP.get_response('www.oreilly.com', '/about/')
response.code                                             # => "200"
response.body.size                                        # => 21835
response['Content-type']
# => "text/html; charset=ISO-8859-1"
puts response.body[0,200]
# <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
#    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
# 
# 
# <html>
# <head>
# <meta http-equiv="content-type" content="text/html; c
#---
require 'uri'
Net::HTTP.get(URI.parse("http://www.oreilly.com"))
Net::HTTP.get_response(URI.parse("http://www.oreilly.com/about/"))
#---
puts "Success!" if response.is_a? Net::HTTPOK
# Success!

puts case response.code[0] # Check the first byte of the response code.
  when ?1 then "Status code indicates an HTTP informational response."
  when ?2 then "Status code indicates success."
  when ?3 then "Status code indicates redirection."
  when ?4 then "Status code indicates client error."
  when ?5 then "Status code indicates server error."
  else "Non-standard status code."
end
# Status code indicates success.
#---
response['Server']
# => "Apache/1.3.34 (Unix) PHP/4.3.11 mod_perl/1.29"
response['SERVER']
# => "Apache/1.3.34 (Unix) PHP/4.3.11 mod_perl/1.29"

response.each_key { |key| puts key }
# x-cache
# p3p
# content-type
# date
# server
# transfer-encoding
#---
Net::HTTP.get_response('www.oreilly.com', '/about/') do |response|
  response.read_body do |segment|
    puts "Received segment of #{segment.size} byte(s)!"
  end
end
# Received segment of 614 byte(s)!
# Received segment of 1024 byte(s)!
# Received segment of 848 byte(s)!
# Received segment of 1024 byte(s)!
# ...
#---
