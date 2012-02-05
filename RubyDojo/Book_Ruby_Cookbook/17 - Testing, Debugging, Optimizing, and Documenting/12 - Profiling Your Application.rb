#!/usr/bin/env ruby
# sequence_counter.rb
require 'profile'

total = 0
# Count the letter sequences containing an a, b, or c.
('a'..'zz').each do |seq|
  ['a', 'b', 'c'].each do |i|
    if seq.index(i)
      total += 1
      break
    end
  end
end
puts "Total: #{total}"
#---
$ ruby sequence_counter.rb
Total: 150
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 54.55     0.30      0.30      702     0.43     0.50  Array#each
 32.73     0.48      0.18        1   180.00   550.00  Range#each
  7.27     0.52      0.04     1952     0.02     0.02  String#index
  3.64     0.54      0.02      702     0.03     0.03  String#succ
  1.82     0.55      0.01      150     0.07     0.07  Fixnum#+
...
#---
#!/usr/bin/env ruby
# sequence_counter2.rb
require 'profile'

total = 0
# Count the letter sequences containing an a, b, or c.
('a'..'zz').each {|seq| total +=1 if seq =~ /[abc]/ }
puts "Total: #{total}"
#---
$ ruby sequence_counter2.rb
Total: 150
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 83.33     0.05      0.05        1    50.00    60.00  Range#each
 16.67     0.06      0.01      150     0.07     0.07  Fixnum#+
  0.00     0.06      0.00        1     0.00     0.00  Fixnum#to_s
...
#---
re = /[abc]/
('a'..'zz').each {|seq| total +=1 if seq =~ re }
#---
