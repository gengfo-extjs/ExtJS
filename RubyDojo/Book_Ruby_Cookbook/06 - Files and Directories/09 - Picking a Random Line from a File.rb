module Enumerable
  def random_line
    selected = nil
    each_with_index { |line, lineno| selected = line if rand < 1.0/lineno }    
    return selected.chomp if selected
  end
end

#Create a file with 1000 lines
open('random_line_test', 'w') do |f| 
  1000.times { |i| f.puts "Line #{i}" }
end

#Pick random lines from the file.
f = open('random_line_test')
f.random_line                                    # => "Line 520"
f.random_line                                    # => nil
f.rewind
f.random_line                                    # => "Line 727"
#---
File.open('random_line_test') do |f|
  l = f.readlines
  l[rand(l.size)].chomp
end
# => "Line 708"
#---
$ ruby -e 'rand < 1.0/$. and line = $_ while gets; puts line.chomp'
#---
