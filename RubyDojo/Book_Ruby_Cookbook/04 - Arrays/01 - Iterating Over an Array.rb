[1, 2, 3, 4].each { |x| puts x }
# 1
# 2
# 3
# 4
#---
[1, 2, 3, 4].collect { |x| x ** 2 }             # => [1, 4, 9, 16]
#---
['a', 'b', 'c'].each_with_index do |item, index| 
  puts "At position #{index}: #{item}"
end
# At position 0: a
# At position 1: b
# At position 2: c
#---
[1, 2, 3, 4].reverse_each { |x| puts x }
# 4
# 3
# 2
# 1
#---
array = ['a', 'b', 'c']
array.collect! { |x| x.upcase }
array                               # => ["A", "B", "C"]
array.map! { |x| x.downcase }
array                               # => ["a", "b", "c"]
#---
array = ['junk', 'junk', 'junk', 'val1', 'val2']
3.upto(array.length-1) { |i| puts "Value #{array[i]}" }
# Value val1
# Value val2

array = ['1', 'a', '2', 'b', '3', 'c']
(0..array.length-1).step(2) do |i| 
  puts "Letter #{array[i]} is #{array[i+1]}"
end
# Letter 1 is a
# Letter 2 is b
# Letter 3 is c
#---
for element in ['a', 'b', 'c']
  puts element
end
# a
# b
# c

for element in (1..3)
  puts element
end
# 1
# 2
# 3
#---
array = ['cherry', 'strawberry', 'orange']

for index in (0...array.length)
  puts "At position #{index}: #{array[index]}"
end

index = 0
while index < array.length
  puts "At position #{index}: #{array[index]}"
  index += 1  
end

index = 0
until index == array.length
  puts "At position #{index}: #{array[index]}"
  index += 1  
end

# At position 0: cherry
# At position 1: strawberry
# At position 2: orange
#---
array = [1,2,3,4,5]
new_array = []
front_index = 0
back_index = array.length-1
while front_index <= back_index
  new_array << array[front_index]
  front_index += 1
  if front_index <= back_index
   new_array << array[back_index]
    back_index -= 1
  end
end
new_array                                 # => [1, 5, 2, 4, 3]
#---
class Array
 def each_from_both_sides
    front_index = 0
    back_index = self.length-1
    while front_index <= back_index
      yield self[front_index]
      front_index += 1
      if front_index <= back_index
	yield self[back_index]
        back_index -= 1
      end
    end
  end  
end

new_array = []
[1,2,3,4,5].each_from_both_sides { |x| new_array << x }
new_array                         # => [1, 5, 2, 4, 3]
#---
class Array
  def collect_from_both_sides
    new_array = []
    each_from_both_sides { |x| new_array << yield(x) }
    return new_array
  end
end

["ham", "eggs", "and"].collect_from_both_sides { |x| x.capitalize }
# => ["Ham", "And", "Eggs"]
#---
