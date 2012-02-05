require 'set'
s = Set.new((1..10).collect)
# => #<Set: {5, 6, 1, 7, 2, 8, 3, 9, 4, 10}>

# Divide the set into the "true" subset and the "false" subset: that
# is, the "less than 5" subset and the "not less than 5" subset.
s.divide { |x| x < 5 }
# => #<Set: {#<Set: {5, 6, 7, 8, 9, 10}>, #<Set: {1, 2, 3, 4}>}>

# Divide the set into the "0" subset and the "1" subset: that is, the
# "even" subset and the "odd" subset.
s.divide { |x| x % 2 }
# => #<Set: {#<Set: {6, 2, 8, 4, 10}>, #<Set: {5, 1, 7, 3, 9}>}>

s = Set.new([1, 2, 3, 'a', 'b', 'c', -1.0, -2.0, -3.0])
# Divide the set into the "String subset, the "Fixnum" subset, and the
# "Float" subset.
s.divide { |x| x.class }

# => #<Set: {#<Set: {"a", "b", "c"}>, 
# =>         #<Set: {1, 2, 3}>, 
# =>         #<Set: {-1.0, -3.0, -2.0}>}>
#---
s = [1, 2, 3, -1, -2, -4].to_set

# Divide the set into sets of numbers with the same absolute value.
s.divide { |x,y| x.abs == y.abs }
# => #<Set: {#<Set: {-1, 1}>, 
# =>         #<Set: {2, -2}>, 
# =>         #<Set: {-4}>, 
# =>         #<Set: {3}>}>

# Divide the set into sets of adjacent numbers
s.divide { |x,y| (x-y).abs == 1 }
# => #<Set: {#<Set: {1, 2, 3}>, 
# =>         #<Set: {-1}>, 
# =>         #<Set: {-4, -3}>}>
#---
s.classify { |x| x.class }
# => {String=>#<Set: {"a", "b", "c"}>, 
# =>  Fixnum=>#<Set: {1, 2, 3}>, 
# =>  Float=>#<Set: {-1.0, -3.0, -2.0}>}
#---
connections = { 1 => 2, 2 => 3, 3 => 1, 4 => 1 }
[1,2,3,4].to_set.divide { |x,y| connections[x] == y }
# => #<Set: {#<Set: {1, 2, 3}>, #<Set: {4}>}>
#---
class Array
  def classify
    require 'set'
    h = {}
    each do |i|
      x = yield(i)
      (h[x] ||= self.class.new) << i
    end
    h
  end

  def divide(&block)
    Set.new(classify(&block).values)
  end
end

[1,1,2,6,6,7,101].divide { |x| x % 2 }
# => #<Set: {[2, 6, 6], [1, 1, 7, 101]}>
#---
class Array
  def divide(&block)
    if block.arity == 2
      counts = inject({}) { |h, x| h[x] ||= 0; h[x] += 1; h}
      to_set.divide(&block).inject([]) do |divided, set|
        divided << set.inject([]) do |partition, e| 
          counts[e].times { partition << e }
          partition
        end
      end       
   else
      Set.new(classify(&block).values)
    end
  end
end

[1,1,2,6,6,7,101].divide { |x,y| (x-y).abs == 1 }
# => [[101], [1, 1, 2], [6, 6, 7]]
#---
