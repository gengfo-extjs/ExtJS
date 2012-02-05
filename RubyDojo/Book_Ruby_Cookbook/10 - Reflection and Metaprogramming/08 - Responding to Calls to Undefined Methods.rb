class MyClass
  def defined_method
    'This method is defined.'
  end

  def method_missing(m, *args)
    "Sorry, I don't know about any #{m} method."
  end
end

o = MyClass.new
o.defined_method                         # => "This method is defined."
o.undefined_method
# => "Sorry, I don't know about any undefined_method method."
#---
class Fixnum
  def method_missing(m, *args)
    if args.size > 0
      raise ArgumentError.new("wrong number of arguments (#{args.size} for 0)")
    end

    match = /^plus_([0-9]+)$/.match(m.to_s)
    if match
      self + match.captures[0].to_i
    else
      raise NoMethodError.
	new("undefined method `#{m}' for #{inspect}:#{self.class}")
    end
  end
end

4.plus_5                                          # => 9
10.plus_0                                         # => 10
-1.plus_2                                         # => 1
100.plus_10000                                    # => 10100
20.send(:plus_25)                                 # => 45

100.minus_3
# NoMethodError: undefined method `minus_3' for 100:Fixnum
100.plus_5(105)
# ArgumentError: wrong number of arguments (1 for 0)
#---
class BackwardsString
  def initialize(s)
   @s = s
  end
  
  def method_missing(m, *args, &block)
    result = @s.send(m, *args, &block)
    result.respond_to?(:to_str) ? BackwardsString.new(result) : result
  end

  def to_s
    @s.reverse
  end

  def inspect
    to_s
  end
end
#---
s = BackwardsString.new("I'm backwards.")             # => .sdrawkcab m'I
s.size                                                # => 14
s.upcase                                              # => .SDRAWKCAB M'I
s.reverse                                             # => I'm backwards.
s.no_such_method
# NoMethodError: undefined method `no_such_method' for "I'm backwards.":String
#---
class Library < Array
  
  def add_book(author, title)
    self << [author, title]
  end
  
  def search_by_author(key)
    reject { |b| !match(b, 0, key) }
  end

  def search_by_author_or_title(key)
    reject { |b| !match(b, 0, key) && !match(b, 1, key) }
  end  
  
  :private

  def match(b, index, key)
    b[index].index(key) != nil
  end
end

l = Library.new
l.add_book("James Joyce", "Ulysses")
l.add_book("James Joyce", "Finnegans Wake")
l.add_book("John le Carre", "The Little Drummer Boy")
l.add_book("John Rawls", "A Theory of Justice")

l.search_by_author("John")
# => [["John le Carre", "The Little Drummer Boy"], 
#     ["John Rawls", "A Theory of Justice"]]

l.search_by_author_or_title("oy")
# => [["James Joyce", "Ulysses"], ["James Joyce", "Finnegans Wake"], 
#     ["John le Carre", "The Little Drummer Boy"]]
#---
class Library
  def method_missing(m, *args)
    search_by_author_or_title(m.to_s)
  end
end

l.oy
# => [["James Joyce", "Ulysses"], ["James Joyce", "Finnegans Wake"], 
#     ["John le Carre", "The Little Drummer Boy"]]

l.Fin
# => [["James Joyce", "Finnegans Wake"]]

l.Jo
# => [["James Joyce", "Ulysses"], ["James Joyce", "Finnegans Wake"], 
#     ["John le Carre", "The Little Drummer Boy"],
#     ["John Rawls", "A Theory of Justice"]]
#---
class StringFactory
  def StringFactory.method_missing(m, *args)
    return String.new(m.to_s, *args)
  end
end

StringFactory.a_string                      # => "a_string"
StringFactory.another_string                # => "another_string"
#---
StringFactory.superclass                    # => Object
#---
25.respond_to? :plus_20                     # => false
#---
class Fixnum
  def respond_to?(m)
    super or (m.to_s =~ /^plus_([0-9]+)$/) != nil
  end
end

25.respond_to? :plus_20                     # => true
25.respond_to? :succ                        # => true
25.respond_to? :minus_20                    # => false
#---
