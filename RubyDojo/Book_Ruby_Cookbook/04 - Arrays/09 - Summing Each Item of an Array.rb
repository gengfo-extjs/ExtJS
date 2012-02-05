collection = [1, 2, 3, 4, 5]
sum = 0
collection.each {|i| sum += i}
sum                                           # => 15
#---
collection = [1, 2, 3, 4, 5]
collection.inject(0) {|sum, i| sum + i}       # => 15
#---
collection = [1, 2, 3, 4, 5]
sum = 0
sum = sum + 1
sum = sum + 2
sum = sum + 3
sum = sum + 4
sum = sum + 5
#---
collection = [1, 2, 3, 4, 5]
collection.inject(1) {|total, i| total * i}     # => 120
#---
