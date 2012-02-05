require 'stringio'
s = StringIO.new %{I am the very model of a modern major general.
I've information vegetable, animal, and mineral.}


s.pos                                 # => 0
s.each_line { |x| puts x }
# I am the very model of a modern major general.
# I've information vegetable, animal, and mineral.
s.eof?                                # => true
s.pos                                 # => 95
s.rewind
s.pos                                 # => 0
s.grep /general/
# => ["I am the very model of a modern major general.\n"]

#---
s = StringIO.new
s.write('Treat it like a file.')
s.rewind
s.write("Act like it's")
s.string                             # => "Act like it's a file."

require 'yaml'
s = StringIO.new
YAML.dump(['A list of', 3, :items], s)
puts s.string
# --- 
# - A list of
# - 3
# - :items
#---
def make_more_interesting(io)
  io << "... OF DOOM!"
end

make_more_interesting("Cherry pie")     # => "Cherry pie... OF DOOM!"

open('interesting_things', 'w') do |f|
  f.write("Nightstand")
  make_more_interesting(f)
end
open('interesting_things') { |f| f.read }
# => "Nightstand... OF DOOM!"
#---
poem = %{The boy stood on the burning deck
Whence all but he had fled
He'd stayed above to wash his neck
Before he went to bed}

#---
output = open("poem", "w")
output.write(poem)
output.close
input = open("poem")

#---
poem.grep /ed$/
# => ["Whence all but he had fled\n", "Before he went to bed"]
input.grep /ed$/
# => ["Whence all but he had fled\n", "Before he went to bed"]

#---
input.grep /ed$/                           # => []
input.rewind
input.grep /ed$/
# => ["Whence all but he had fled\n", "Before he went to bed"]
#---
def fifth_byte(file)
  file.seek(5)
  file.read(1)
end

fifth_byte("123456")
# NoMethodError: undefined method `seek' for "123456":String
fifth_byte(StringIO.new("123456"))          # => "6"
#---
def file_operation(io)
  io = StringIO(io) if io.respond_to? :to_str && !io.is_a? StringIO
  #Do the file operation...
end
#---
s = StringIO.new
s << "A string"
s.read
s << ", and more."
s.rewind
s.read                                # => "A string, and more."
#---
