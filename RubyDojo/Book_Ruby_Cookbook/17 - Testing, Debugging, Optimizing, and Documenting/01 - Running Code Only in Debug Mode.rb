#!/usr/bin/env ruby
# divide.rb
numerator = rand(100)
denominator = rand(10)
$stderr.puts "Dividing #{numerator} by #{denominator}" if $DEBUG
puts numerator / denominator
#---
$ ./divide.rb --debug
Dividing 64 by 9
7

$ ./divide.rb --debug
Dividing 93 by 2
46

$ ./divide.rb --debug
Dividing 54 by 0
Exception `ZeroDivisionError' at divide_buggy.rb:6 - divided by 0
divide_buggy.rb:6:in `/': divided by 0 (ZeroDivisionError)
        from divide_buggy.rb:6
#---
$ ./divide.rb
24 
#---
require 'fileutils'
FileUtils.cp('source', 'destination', $DEBUG)
#---
def pdebug(str)
  $stderr.puts('DEBUG: ' + str) if $DEBUG
end

pdebug "Dividing #{numerator} by #{denominator}"
#---
def debug(if_level)
  yield if ($DEBUG == true) || ($DEBUG && $DEBUG >= if_level)
end	

def pdebug(str, if_level=1)
  debug(if_level) { $stderr.puts "DEBUG: " + str }
end
#---
