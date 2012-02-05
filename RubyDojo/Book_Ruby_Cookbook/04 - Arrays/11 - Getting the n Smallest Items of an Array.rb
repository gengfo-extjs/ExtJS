[3, 5, 11, 16].min                                # => 3
["three", "five", "eleven", "sixteen"].min        # => "eleven"
["three", "five", "eleven", "sixteen"].min { |x,y| x.size <=> y.size }
# => "five"
#---
[3, 5, 11, 16].max                                # => 16
["three", "five", "eleven", "sixteen"].max        # => "three"
["three", "five", "eleven", "sixteen"].max { |x,y| x.size <=> y.size }
# => "sixteen"
#---
l = [1, 60, 21, 100, -5, 20, 60, 22, 85, 91, 4, 66]
sorted = l.sort

#The top 5
sorted[-5...sorted.size]
# => [60, 66, 85, 91, 100]

#The bottom 5
sorted[0...5]
# => [-5, 1, 4, 20, 21]
#---
require 'sortedarray'

module Enumerable
  def min_n(n, &block)
    block ||= proc { |x,y| x <=> y } 
    stable = SortedArray.new(&block)
    each do |x| 
    stable << x if stable.size < n or block.call(x, stable[-1]) == -1
      stable.pop until stable.size <= n
    end
    return stable
  end

  def max_n(n, &block)
    block ||= proc { |x,y| x <=> y }
    stable = SortedArray.new(&block)
    each do |x| 
      stable << x if stable.size < n or block.call(x, stable[0]) == 1
      stable.shift until stable.size <= n
    end
    return stable
  end
end

l = [1, 60, 21, 100, -5, 20, 60, 22, 85, 91, 4, 66]
l.max_n(5)                              # => [60, 66, 85, 91, 100]
l.min_n(5)                              # => [-5, 1, 4, 20, 21]

l.min_n(5) { |x,y| x.abs <=> y.abs }    # => [1, 4, -5, 20, 21]
#---
