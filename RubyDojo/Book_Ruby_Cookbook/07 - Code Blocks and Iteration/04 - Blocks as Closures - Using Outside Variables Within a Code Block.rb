def add_to_all(array, number)
  array.collect { |x| x + number }
end

add_to_all([1, 2, 3], 10)                # => [11, 12, 13]
#---
tax_percent = 6
position = lambda do
  "I have always supported a #{tax_percent}% tax on imported limes."
end
position.call
# => "I have always supported a 6% tax on imported limes."

tax_percent = 7.25
position.call 
# => "I have always supported a 7.25% tax on imported limes."
#---
counter = 0
4.times { counter += 1; puts "Counter now #{counter}"}
# Counter now 1
# Counter now 2
# Counter now 3
# Counter now 4
counter                                                  # => 4
#---
accumulator = []
[1, 2, 3].reverse_each { |x| accumulator << x + 1 }

accumulator                  # => [4, 3, 2]
#---
