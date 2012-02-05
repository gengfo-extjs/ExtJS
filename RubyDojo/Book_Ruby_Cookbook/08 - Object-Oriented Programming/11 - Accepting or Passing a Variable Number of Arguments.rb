def sum(*numbers)
  puts "I'm about to sum the array #{numbers.inspect}"
  numbers.inject(0) { |sum, x| sum += x }
end

sum(1, 2, 10)              
# I'm about to sum the array [1, 2, 10]
# => 13

sum(2, -2, 2, -2, 2, -2, 2, -2, 2)
# I'm about to sum the array [2, -2, 2, -2, 2, -2, 2, -2, 2]
# => 2

sum  
# I'm about to sum the array []              
# => 0
#---
to_sum = []
1.upto(10) { |x| to_sum << x }
sum(*to_sum)
# I'm about to sum the array [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# => 55
#---
sum(to_sum)
# I'm about to sum the array [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]]
# TypeError: Array can't be coerced into Fixnum
#---
printf('%s | %s', 'left', 'right')
# left | right
#---
inputs = ['left', 'right']
printf('%s | %s', *inputs) 
# left | right
#---
def format_list(header, footer='', *data)
  puts header
  puts (line = '-' * header.size)
  puts data.join("\n")
  puts line
  puts footer
end

cozies = 21
gaskets = 10
format_list("Yesterday's productivity numbers:", 'Congratulations!', 
            "#{cozies} slime mold cozies", "#{gaskets} Sierpinski gaskets")
# Yesterday's productivity numbers:
# ---------------------------------
# 21 slime mold cozies
# 10 Sierpinski gaskets
# ---------------------------------
# Congratulations!
#---
ranges = [[1, 10], [1, 6, true], [25, 100, false], [6, 9]]
ranges.collect { |l| Range.new(*l) }
# => [1..10, 1...6, 25..100, 6..9]
#---
