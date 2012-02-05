?a                       # => 97
?!                       # => 33
?\n                      # => 10
'a'[0]                   # => 97
'bad sound'[1]           # => 97
#---
97.chr                   # => "a"
33.chr                   # => "!"
10.chr                   # => "\n"
0.chr                    # => "\000"
256.chr
# RangeError: 256 out of char range
#---
