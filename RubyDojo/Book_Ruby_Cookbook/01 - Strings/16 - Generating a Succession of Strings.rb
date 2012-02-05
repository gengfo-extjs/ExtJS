('aa'..'ag').each { |x| puts x }
# aa
# ab
# ac
# ad
# ae
# af
# ag
#---
def endless_string_succession(start)
  while true
    yield start 
    start = start.succ
  end
end
#---
endless_string_succession('fol') do |x|
  puts x
  break if x[-1] == x[-2]    
end
# fol
# fom
# fon
# foo
#---
'89999'.succ                           # => "90000"
'nzzzz'.succ                           # => "oaaaa"
#---
'Zzz'.succ                             # => "AAaa"
#---
'z'.succ                               # => "aa"
'aa'.succ                              # =>  "ab"
'zz'.succ                              # => "aaa"
#---
'AA'.succ                              # =>  "AB"
'AZ'.succ                              # =>  "BA"
'ZZ'.succ                              # => "AAA" 
'aZ'.succ                              # =>  "bA"
'Zz'.succ                              # => "AAa"
#---
'foo19'.succ                           # => "foo20"
'foo99'.succ                           # => "fop00"
'99'.succ                              # => "100"
'9Z99'.succ                            # => "10A00"
#---
'10-99'.succ                           # => "11-00"
#---
'a-a'.succ                             # => "a-b"
'z-z'.succ                             # => "aa-a"
'Hello!'.succ                          # => "Hellp!"
%q{'zz'}.succ                          # => "'aaa'"
%q{z'zz'}.succ                         # => "aa'aa'"
'$$$$'.succ                            # => "$$$%"

s = '!@-'
13.times { puts s = s.succ }
# !@.
# !@/
# !@0
# !@1
# !@2
# ...
# !@8
# !@9
# !@10
#---
("a".."e").to_a.reverse_each { |x| puts x }
# e
# d
# c
# b
# a
#---
