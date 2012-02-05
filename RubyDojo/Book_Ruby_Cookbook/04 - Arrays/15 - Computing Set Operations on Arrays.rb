#Union
[1,2,3] | [1,4,5]            # => [1, 2, 3, 4, 5]

#Intersection
[1,2,3] & [1,4,5]            # => [1]

#Difference
[1,2,3] - [1,4,5]            # => [2, 3]
#---
require 'set'
a = [1,2,3]
b = [3,4,5]
a.to_set ^ b.to_set          # => #<Set: {5, 1, 2, 4}>
(a | b) - (a & b)            # => [1, 2, 4, 5]
#---
array = [1,2,3]
set = [3,4,5].to_set

set & array                 # => #<Set: {3}>

array & set                 
# TypeError: cannot convert Set into Array
#---
[3,3] & [3,3]               # => [3]
[3,3] | [3,3]               # => [3]
[1,2,3,3] - [1]             # => [2, 3, 3]
[1,2,3,3] - [3]             # => [1, 2]
[1,2,3,3] - [2,2,3]         # => [1]
#---
u = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]
a = [:red, :blue]
u - a                   # => [:orange, :yellow, :green, :indigo, :violet]
#---
def natural_numbers_except(exclude)
  exclude_map = {}
  exclude.each { |x| exclude_map[x] = true } 
  x = 1
  while true
    yield x unless exclude_map[x]
    x = x.succ
  end
end

natural_numbers_except([2,3,6,7]) do |x|
 break if x > 10
 puts x
end
# 1
# 4
# 5
# 8
# 9
# 10
#---
module Enumerable
  def cartesian(other)
    res = []
    each { |x| other.each { |y| res << [x, y] } }
    return res
  end
end

[1,2,3].cartesian(['a',5,6])
# => [[1, "a"], [1, 5], [1, 6], 
# =>  [2, "a"], [2, 5], [2, 6],
# =>  [3, "a"], [3, 5], [3, 6]]
#---
module Enumerable
  def cartesian(other)
    inject([]) { |res, x| other.inject(res) { |res, y| res << [x,y] } }
  end
end
#---
