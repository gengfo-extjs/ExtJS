def call_twice
  puts "I'm about to call your block."
  yield
  puts "I'm about to call your block again."
  yield
end

call_twice { puts "Hi, I'm a talking code block." }
# I'm about to call your block.
# Hi, I'm a talking code block.
# I'm about to call your block again.
# Hi, I'm a talking code block.
#---
def repeat(n)
 if block_given?
    n.times { yield }

  else
    raise ArgumentError.new("I can't repeat a block you don't give me!")
  end
end

repeat(4) { puts "Hello." }
# Hello.
# Hello.
# Hello.
# Hello.

repeat(4)
# ArgumentError: I can't repeat a block you don't give me!
#---
puts("Print this message.") { puts "And also run this code block!" }
# Print this message.
#---
def call_twice
  puts "Calling your block."
  ret1 = yield("very first")
  puts "The value of your block: #{ret1}"

  puts "Calling your block again."
  ret2 = yield("second")
  puts "The value of your block: #{ret2}"
end

call_twice do |which_time|
  puts "I'm a code block, called for the #{which_time} time."
  which_time == "very first" ? 1 : 2
end
# Calling your block.
# I'm a code block, called for the very first time.
# The value of your block: 1
# Calling your block again.
# I'm a code block, called for the second time.
# The value of your block: 2
#---
squares = {0=>0, 1=>1, 2=>4, 3=>9}
squares.find { |key, value| key > 1 }          # => [2, 4]
#---
class Hash
  def find_all
    new_hash = Hash.new
    each { |k,v| new_hash[k] = v if yield(k, v) }
    new_hash
  end
end

squares.find_all { |key, value| key > 1 }        # => {2=>4, 3=>9}
#---
squares.dup.delete_if { |key, value| key > 1 }   # => {0=>0, 1=>1}
squares.dup.delete_if { |key, value| key <= 1 }  # => {2=>4, 3=>9} 
#---
[1, 2, 3].each
# LocalJumpError: no block given
#---
