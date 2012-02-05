def mean(array)
  array.inject(0) { |sum, x| sum += x } / array.size.to_f
end

mean([1,2,3,4])                                  # => 2.5
mean([100,100,100,100.1])                        # => 100.025
mean([-100, 100])                                # => 0.0
mean([3,3,3,3])                                  # => 3.0
#---
def median(array, already_sorted=false)
  return nil if array.empty?
  array = array.sort unless already_sorted
  m_pos = array.size / 2
  return array.size % 2 == 1 ? array[m_pos] : mean(array[m_pos-1..m_pos])
end

median([1,2,3,4,5])                             # => 3
median([5,3,2,1,4])                             # => 3
median([1,2,3,4])                               # => 2.5
median([1,1,2,3,4])                             # => 2
median([2,3,-100,100])                          # => 2.5
median([1, 1, 10, 100, 1000])                   # => 10
#---
def modes(array, find_all=true)
  histogram = array.inject(Hash.new(0)) { |h, n| h[n] += 1; h }
  modes = nil
  histogram.each_pair do |item, times| 
    modes << item if modes && times == modes[0] and find_all
    modes = [times, item] if (!modes && times>1) or (modes && times>modes[0])
  end
  return modes ? modes[1...modes.size] : modes
end

modes([1,2,3,4])                                # => nil
modes([1,1,2,3,4])                              # => [1]
modes([1,1,2,2,3,4])                            # => [1, 2]
modes([1,1,2,2,3,4,4])                          # => [1, 2, 4]
modes([1,1,2,2,3,4,4], false)                   # => [1]
modes([1,1,2,2,3,4,4,4,4,4])                    # => [4]
#---
def mean_without_float_conversion(array)
  array.inject(0) { |x, sum| sum += x } / array.size
end

require 'rational'
numbers = [Rational(2,3), Rational(3,4), Rational(6,7)]
mean(numbers)
# => 0.757936507936508
mean_without_float_conversion(numbers)
# => Rational(191, 252)
#---
mean([1, 100, 100000])                          # => 33367.0
median([1, 100, 100000])                        # => 100

mean([1, 100, -1000000])                        # => -333299.666666667
median([1, 100, -1000000])                      # => 1
#---
median(["a", "z", "b", "l", "m", "j", "b"])
# => "j"
median(["a", "b", "c", "d"])
# TypeError: String can't be coerced into Fixnum
#---
def mean_and_standard_deviation(array)
  m = mean(array)
  variance = array.inject(0) { |variance, x| variance += (x - m) ** 2 }
  return m, Math.sqrt(variance/(array.size-1))
end

#All the items in the list are close to the mean, so the standard
#deviation is low.
mean_and_standard_deviation([1,2,3,1,1,2,1])
# => [1.57142857142857, 0.786795792469443]

#The outlier increases the mean, but also increases the standard deviation.
mean_and_standard_deviation([1,2,3,1,1,2,1000])
# => [144.285714285714, 377.33526837801]
#---
