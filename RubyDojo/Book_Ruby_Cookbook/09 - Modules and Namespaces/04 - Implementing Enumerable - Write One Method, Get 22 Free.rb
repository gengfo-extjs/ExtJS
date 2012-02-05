class MultiArray
  include Enumerable

  def initialize(*arrays)
    @arrays = arrays
  end

  def each
    @arrays.each { |a| a.each { |x| yield x } }
  end
end

ma = MultiArray.new([1, 2], [3], [4])
ma.collect                                   # => [1, 2, 3, 4]
ma.detect { |x| x > 3 }                      # => 4
ma.map { |x| x ** 2 }                        # => [1, 4, 9, 16]
ma.each_with_index { |x, i| puts "Element #{i} is #{x}" }
# Element 0 is 1
# Element 1 is 2
# Element 2 is 3
# Element 3 is 4
#---
Enumerable.instance_methods.sort
# => ["all?", "any?", "collect", "detect", "each_with_index", "entries", 
# =>  "find", "find_all", "grep", "include?", "inject", "map", "max", 
# =>  "member?", "min", "partition", "reject", "select", "sort", "sort_by", 
# =>  "to_a", "zip"]
#---
ma.sort                                   # => [1, 2, 3, 4]
mixed_type_ma = MultiArray.new([1, 2, 3], ["a", "b", "c"])
mixed_type_ma.sort
# ArgumentError: comparison of Fixnum with String failed
#---
[1, 2, 3, "a", "b", "c"].sort
# ArgumentError: comparison of Fixnum with String failed
#---
class Module
  include Enumerable
  def each
    instance_methods.each { |x| yield x }
  end
end

# Find all instance methods of String that modify the string in place.
String.find_all { |method_name| method_name[-1] == ?! }
# => ["sub!", "upcase!", "delete!", "lstrip!", "succ!", "gsub!",
# =>  "squeeze!", "downcase!", "rstrip!", "slice!", "chop!", "capitalize!",
# =>  "tr!", "chomp!", "next!", "swapcase!", "reverse!", "tr_s!", "strip!"]

# Find all instance methods of Fixnum that take 2 arguments.
sample = 0
sample.class.find_all { |method_name| sample.method(method_name).arity == 2 }
# => ["instance_variable_set", "between?"]
#---
