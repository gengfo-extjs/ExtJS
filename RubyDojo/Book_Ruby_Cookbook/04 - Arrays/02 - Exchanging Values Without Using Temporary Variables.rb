a = 1
b = 2
a, b = b, a
a                                 # => 2
b                                 # => 1
#---
a, b, c = :red, :green, :blue
c, a, b = a, b, c
a                                 # => :green
b                                 # => :blue
c                                 # => :red
#---
array = [:red, :green, :blue]
c, a, b = array
a                                 # => :green
b                                 # => :blue
c                                 # => :red
#---
a, b, *c = [12, 14, 178, 89, 90]
a                                 # => 12
b                                 # => 14
c                                 # => [178, 89, 90]
#---
a, b = 1, 2
x = a
a = b
b = x
#---
a, b = 5, 10
a, b = b/a, a-1                   # => [2, 4]


a, b, c = 'A', 'B', 'C'
a, b, c = [a, b], { b => c }, a
a                                 # => ["A", "B"]
b                                 # => {"B"=>"C"}
c                                 # => "A"
#---
a, b = 1, 2
a, b = b
a                                 # => 2
b                                 # => nil
#---
a, b = rand(1000), rand(1000)     # => [595, 742]
a = a ^ b                         # => 181
b = b ^ a                         # => 595
a = a ^ b                         # => 742

[a, b]                            # => [742, 595]
#---
