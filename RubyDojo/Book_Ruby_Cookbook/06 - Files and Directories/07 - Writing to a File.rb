open('output', 'w') { |f| f << "This file contains great truths.\n" }
open('output', 'w') do |f| 
  f.puts 'The great truths have been overwritten with an advertisement.'
end

open('output') { |f| f.read }
# => "The great truths have been overwritten with an advertisement.\n"
#---
open('output', "a") { |f| f.puts 'Buy Ruby(TM) brand soy sauce!' }

open('output') { |f| puts f.read }
# The great truths have been overwritten with an advertisement.
# Buy Ruby(TM) brand soy sauce!
#---
open('output', 'w') do |f|
  [1,2,3].each { |i| f << i << ' and a ' }
end

open('output') { |f| f.read }               # => "1 and a 2 and a 3 and a "
#---
open('output', 'w') do |f|
  f << 'This is going into the Ruby buffer.'
  f.flush                             # Now it's going into the OS buffer.
end

IO.sync = false
open('output', 'w') { |f| f << 'This is going straight into the OS buffer.' }
#---
