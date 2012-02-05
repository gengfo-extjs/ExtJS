#!/usr/bin/ruby -w
# interactive_or_not.rb
if STDIN.tty?
  puts "Let me be the first to welcome my human overlords."
else
  puts "How goes the revolution, brother software?"
end
#---
$ ./interactive_or_not.rb
Let me be the first to welcome my human overlords.

$ echo "Some data" | interactive_or_not.rb
How goes the revolution, brother software?

$ ./interactive_or_not.rb < input_file
How goes the revolution, brother software?
#---
