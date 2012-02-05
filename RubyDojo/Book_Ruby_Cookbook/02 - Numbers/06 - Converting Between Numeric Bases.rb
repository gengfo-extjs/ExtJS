0b100                          # => 4
0o100                          # => 64
0x100                          # => 256
#---
"1045".to_i(10)                   # => 1045
"-1001001".to_i(2)                # => -73
"abc".to_i(16)                    # => 2748
"abc".to_i(20)                    # => 4232
"number".to_i(36)                 # => 1442151747
"zz1z".to_i(36)                   # => 1678391
"abcdef".to_i(16)                 # => 11259375
"AbCdEf".to_i(16)                 # => 11259375
#---
42.to_s(10)                       # => "42"
-100.to_s(2)                      # => "-1100100"
255.to_s(16)                      # => "ff"
1442151747.to_s(36)               # => "number"
#---
"6".to_i(2)                       # => 0
"0".to_i(1)
# ArgumentError: illegal radix 1
40.to_s(37)
# ArgumentError: illegal radix 37
#---
