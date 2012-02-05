require 'orderedhash'
h = OrderedHash.new
h[1] = 1
h["second"] = 2
h[:third] = 3

h.keys                                          # => [1, "second", :third]
h.values                                        # => [1, 2, 3]
h.each { |k,v| puts "The #{k} counting number is #{v}" }
# The 1 counting number is 1
# The second counting number is 2
# The third counting number is 3
#---
