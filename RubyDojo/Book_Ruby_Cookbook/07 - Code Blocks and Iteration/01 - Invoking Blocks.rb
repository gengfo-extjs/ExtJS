block = { |x| puts x }                 # WRONG

# SyntaxError: compile error
#---
block = lambda { |x| puts x }          # RIGHT
#---
block.call "Hello World!" 
# Hello World!
#---
def my_lambda(&block)
  block
end

b = my_lambda { puts "Hello World My Way!" }
b.call
# Hello World My Way!
#---
b.class                                # => Proc
#---
block = Proc.new { |x| puts x }

block = proc { |x| puts x }
block = lambda { |x| puts x }
#---
add_lambda = lambda { |x,y| x + y }

add_lambda.call(4)
# ArgumentError: wrong number of arguments (1 for 2)

add_lambda.call(4,5,6)
# ArgumentError: wrong number of arguments (3 for 2)
#---
add_procnew = Proc.new { |x,y| x + y }

add_procnew.call(4)
# TypeError: nil can't be coerced into Fixnum

add_procnew.call(4,5,6)                               # => 9
#---
