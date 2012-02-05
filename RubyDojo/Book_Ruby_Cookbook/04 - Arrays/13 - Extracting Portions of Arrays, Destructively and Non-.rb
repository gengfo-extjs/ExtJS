a = ("a".."h").to_a             # => ["a", "b", "c", "d", "e", "f", "g", "h"]

a[0]                            # => "a"
a[1]                            # => "b"

a.at(1)                         # => "b"
a.slice(1)                      # => "b"
a[-1]                           # => "h"
a[-2]                           # => "g"
a[1000]                         # => nil
a[-1000]                        # => nil
#---
a[2..5]                         # => ["c", "d", "e", "f"]
a[2...5]                        # => ["c", "d", "e"]
a[0..0]                         # => ["a"]
a[1..-4]                        # => ["b", "c", "d", "e"]
a[5..1000]                      # => ["f", "g", "h"]

a[2..0]                         # => []
a[0...0]                        # => []

a[-3..2]                        # => []

#---
a[2, 4]                         # => ["c", "d", "e", "f"]
a[2, 3]                         # => ["c", "d", "e"]
a[0, 1]                         # => ["a"]
a[1, 2]                         # => ["b", "c"]
a[-4, 2]                        # => ["e", "f"]
a[5, 1000]                      # => ["f", "g", "h"]
#---
a.slice!(2..5)                  # => ["c", "d", "e", "f"]
a                               # => ["a", "b", "g", "h"]

a.slice!(0)                     # => "a"
a                               # => ["b", "g", "h"]

a.slice!(1,2)                   # => ["g", "h"]
a                               # => ["b"]
#---
a = ("a".."h").to_a              # => ["a", "b", "c", "d", "e", "f", "g", "h"]
a.values_at(0)                   # => ["a"]
a.values_at(1, 0, -2)            # => ["b", "a", "g"]
a.values_at(4, 6, 6, 7, 4, 0, 3) # => ["e", "g", "g", "h", "e", "a", "d"]
#---
a.find_all { |x| x < "e" }       # => ["a", "b", "c", "d"]
a.reject { |x| x < "e" }         # => ["e", "f", "g", "h"]
#---
a.grep /[aeiou]/                 # => ["a", "e"]
a.grep /[^g]/                    # => ["a", "b", "c", "d", "e", "f", "h"]
#---
class Array 
  def strip_values_at!(*args)
    args.each do |x|
      #For each mentioned index, replace its value with a dummy object.
      values = []
      dummy = Object.new
      args.each do |i| 
        if i < size
          values << self[i]
          self[i] = dummy
        end
      end
      #Strip out the dummy object.
      delete(dummy)
      return values
    end
  end
end

a = ("a".."h").to_a
a.strip_values_at!(1, 0, -2)            # => ["b", "a", "g"]
a                                       # => ["c", "d", "e", "f", "h"]

a.strip_values_at!(1000)                # => []
a                                       # => ["c", "d", "e", "f", "h"]

#---
class Array 
  def extract!
    ary = self.dup
    self.reject! { |x| yield x }
    ary - self
  end
end

a = ("a".."h").to_a
a.extract! { |x| x < "e" && x != "b" }     # => ["a", "c", "d"]
a                # => ["b", "e", "f", "g", "h"]

#---
class Array
  def grep_extract!(re)
    extract! { |x| re.match(x) }
  end
end


a = ("a".."h").to_a
a.grep_extract!(/[aeiou]/)           # => ["a", "e"]
a   # => ["b", "c", "d", "f", "g", "h"]
#---
