require 'ping'

Ping::pingecho('oreilly.com')                        # => true
Ping::pingecho('localhost')                          # => true
Ping::pingecho('127.0.0.1')                          # => true
Ping::pingecho('no.such.domain')                     # => false
Ping::pingecho('222.222.222.222')                    # => false
#---
system('ping -c1 www.oreilly.com')
# 64 bytes from 208.201.239.36: icmp_seq=0 ttl=42 time=27.2 ms
#
# --- www.oreilly.com ping statistics ---
# 1 packets transmitted, 1 packets received, 0% packet loss
# round-trip min/avg/max = 27.2/27.2/27.2 ms
# => true
#---
Ping::pingecho('microsoft.com')                         # => false

require 'net/http'
Net::HTTP.start('microsoft.com') { 'success!' }         # => "success!"
Net::HTTP.start('no.such.domain') { "success!" }        
# SocketError: getaddrinfo: Name or service not known
```#---
