s = 'My kingdom for a string!'
s.slice(3,7)                        # => "kingdom"
s[3,7]                              # => "kingdom"
s[0,3]                              # => "My "
s[11, 5]                            # => "for a"
s[11, 17]                           # => "for a string!"
#---
s[/.ing/]                           # => "king"
s[/str.*/]                          # => "string!"
#---
s.slice(3)                         # => 107
s[3]                               # => 107
107.chr                            # => "k"
s.slice(3,1)                       # => "k"
s[3,1]                             # => "k"
#---
s.slice(-7,3)                      # => "str"
s[-7,6]                            # => "string"
#---
s[15...s.length]                   # => "a string!"
#---
