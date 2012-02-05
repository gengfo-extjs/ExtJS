require 'net/telnet'

webserver = Net::Telnet::new('Host' => 'www.oreilly.com',
                             'Port' => 80,
	                     'Telnetmode' => false)
size = 0
webserver.cmd("GET / HTTP/1.1\nHost: www.oreilly.com\n") do |c| 
  size += c.size
  puts "Read #{c.size} bytes; total #{size}"
end
# Read 1431 bytes; total 1431
# Read 1434 bytes; total 2865
# Read 1441 bytes; total 4306
# Read 1436 bytes; total 5742
# ...
# Read 1430 bytes; total 39901
# Read 2856 bytes; total 42757
# /usr/lib/ruby/1.8/net/telnet.rb:551:in `waitfor': 
#   timed out while waiting for more data (Timeout::Error)
#---
require 'net/telnet'

bbs = Net::Telnet::new('Host' => 'bbs.example.com')

puts bbs.waitfor(/What is your name\?/)
# The Retro Telnet BBS
# Where it's been 1986 since 1993.
# Dr. Phineas Goodbody, proprietor
#
# What is your name? (NEW for new user)

bbs.cmd('String'=>'leonardr', 'Match'=>/password:/) { |c| puts c }
# Hello, leonardr. Please enter your password:

bbs.cmd('my_password') { |c| puts c }
# Welcome to the Retro Telnet BBS, leonardr.
# Choose from the menu below:
# ...
#---
require 'net/telnet'

webserver = Net::Telnet::new('Host' => 'www.oreilly.com',
                             'Port' => 80,
                             'Waittime' => 0.1,
                             'Prompt' => /.*/,
                             'Telnetmode' => false)
size = 0
webserver.cmd("GET / HTTP/1.1\nHost: www.oreilly.com\n") do |c| 
  size += c.size
  puts "Read #{c.size} bytes; total #{size}"
end
#---
require 'net/telnet'
adventure = Net::Telnet::new('Host' => 'games.example.com',
                             'Port' => 23266,
                             'Waittime' => 2.0,
                             'Prompt' => /.*/)

commands = ['no', 'enter building', 'get lamp'] # And so on...
commands.each do |command|
  adventure.cmd(command) { |c| print c }
end
# Welcome to Adventure!!  Would you like instructions?
# no
#
# You are standing at the end of a road before a small brick building.
# Around you is a forest.  A small stream flows out of the building and
# down a gully.
# enter building
#
# You are inside a building, a well house for a large spring.
# There are some keys on the ground here.
# There is a shiny brass lamp nearby.
# There is food here.
# There is a bottle of water here.
#
# get lamp
# OK
#---
