"4".to_i                                           # => 4
4.to_s                                             # => "4"
Time.now.to_f                                      # => 1143572140.90932
{ "key1" => "value1", "key2" => "value2" }.to_a
# => [["key1", "value1"], ["key2", "value2"]]
#---
def print_each(array)
  array.each { |x| puts x.inspect }
end

hash = { "pickled peppers" => "peck of",
         "sick sheep"      => "sixth" }
print_each(hash.to_a)
# ["sick sheep", "sixth"]
# ["pickled peppers", "peck of"]

print_each(hash)
# ["sick sheep", "sixth"]
# ["pickled peppers", "peck of"]
#---
array = hash.to_a
# => [["sick sheep", "sixth"], ["pickled peppers", "peck of"]]

# Print out a tongue-twisting invoice.
until array.empty?
  item, quantity = array.pop
  puts "#{quantity} #{item}"
end
# peck of pickled peppers
# sixth sick sheep
#---
hash.sort
# => [["pickled peppers", "peck of"], ["sick sheep", "sixth"]]
#---
3/4                                              # => 0
3/4.to_f                                         # => 0.75
#---
require 'rational'
Rational(1, 3).to_f                             # => 0.333333333333333
Rational(11, 5).to_i                            # => 2
2.to_r                                          # => Rational(2, 1)
#---
require 'bigdecimal'
require 'bigdecimal/util'

one_third = 1/3.0          # => 0.333333333333333
one_third.to_r                                     
# NoMethodError: undefined method `to_r' for 0.333333333333333:Float
one_third.to_d.to_r        # => Rational(333333333333333, 1000000000000000)
#---
20.to_d                                            
# NoMethodError: undefined method `to_d' for 20:Fixnum
20.to_r.to_d               # => #<BigDecimal:b7bfd214,'0.2E2',4(48)>
#---
require 'complex'
i = Complex(0, 1)                      # => Complex(0, 1)
i.coerce(3)                            # => [Complex(3, 0), Complex(0, 1)]
i.coerce(2.5)                          # => [Complex(2.5, 0), Complex(0, 1)]
#---
[1, 2, 3].to_s                                   # => "123"
[1, 2, 3].inspect                                # => "[1, 2, 3]"
#---
