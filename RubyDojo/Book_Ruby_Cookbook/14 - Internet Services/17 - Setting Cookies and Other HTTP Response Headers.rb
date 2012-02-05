#!/usr/bin/ruby
# headers.cgi

require "cgi"
cgi = CGI.new("html3")

# Retrieve or create the "rubycookbook" cookie
cookie = cgi.cookies['rubycookbook']
cookie = CGI::Cookie.new('rubycookbook', 'hits=0', 
                         "last=#{Time.now}") if cookie.empty?

# Read the values in the cookie for future use
hits = cookie.value[0].split('=')[1]
last = cookie.value[1].split('=')[1]

# Set new values in the cookie
cookie.value[0] = "hits=#{hits.succ}"
cookie.value[1] = "last=#{Time.now}"
#---
# Create a hash of HTTP response headers.
header = { 'status'      => 'OK',
           'cookie'      => [cookie],
           'Refresh'     => 2,
           'Recipe Name' => 'Setting HTTP Response Headers',
           'server'      => ENV['SERVER_SOFTWARE']  }

cgi.out(header) do
  cgi.html('PRETTY' => '  ') do
    cgi.head { cgi.title { 'Setting HTTP Response Headers' } } +
    cgi.body do
      cgi.p('Your headers:') +
      cgi.pre{ cgi.header(header) } +
      cgi.pre do
        "Number of times your browser hit this cgi: #{hits}\n"+
        "Last connected: #{last}"
      end
    end
 end
end
#---
