#!/usr/bin/ruby -w
# readline.rb
require 'readline'
vegetable = Readline.readline("What's your favorite vegetable?> ")
puts "#{vegetable.capitalize}? Are you crazy?"
#---
$ ruby readline.rb
What's your favorite vegetable?> okra
Okra? Are you crazy?
#---
# readline_windows.rb
print "What's your favorite vegetable?> "
puts gets.chomp.capitalize + "? Are you crazy?"
#---
#!/usr/bin/ruby -w
# mini_irb.rb
require 'readline'
line = 0
loop do
  eval Readline.readline('%.3d> ' % line, true)
  line += 1
end
#---
