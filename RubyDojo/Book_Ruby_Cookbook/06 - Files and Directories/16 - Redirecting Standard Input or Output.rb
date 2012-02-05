#!/usr/bin/env ruby
# redirect_stdout.rb
require 'stringio'
new_stdout = StringIO.new

$stdout = new_stdout
puts 'Hello, hello.'
puts "I'm writing to standard output."

$stderr.puts "#{new_stdout.size} bytes written to standard ouput so far."
$stderr.puts "You haven't seen it on the screen yet, but you soon will:"
$stderr.puts new_stdout.string
#---
$ ruby redirect_stdout.rb
46 bytes written to standard output so far.
You haven't seen it on the screen yet, but you soon will:
Hello, hello.
I'm writing to standard output.
#---
