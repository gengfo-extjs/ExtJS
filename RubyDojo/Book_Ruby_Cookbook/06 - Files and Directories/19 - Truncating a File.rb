filename = 'truncate.txt'
open(filename, 'w') { |f| f << "All of this will be truncated." }
File.size(filename)                        # => 30

f = open(filename, 'w') {}
File.size(filename)                        # => 0
#---
open(filename, 'w') { |f| f << "Here are some new contents." }

File.size(filename)                       # => 27

f = open(filename, File::TRUNC) {}
File.size(filename)                       # => 0

#---
open(filename, File::TRUNC) do |f| 
  f << "At last, an empty file to write to!"
end
# IOError: not opened for writing
#---
f = open(filename, 'w') do |f|
  f << 'These words will remain intact after the file is truncated.'
end
File.size(filename)                # => 59

File.truncate(filename, 30)
File.size(filename)                # => 30
open(filename) { |f| f.read }      # => "These words will remain intact"
#---
f = open(filename, "w") { |f| f << "Brevity is the soul of wit." }
File.size(filename)                       # => 27
File.truncate(filename, 30)
File.size(filename)                       # => 30
open(filename) { |f| f.read }
# => "Brevity is the soul of wit.\000\000\000"
#---
