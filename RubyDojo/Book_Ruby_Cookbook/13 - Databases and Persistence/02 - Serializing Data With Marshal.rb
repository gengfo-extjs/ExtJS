Marshal.dump(10)                              # => "\004\010i\017"
Marshal.dump('ten')                           # => "\004\010\"\010ten"
Marshal.dump('10')                            # => "\004\010\"\a10"

Marshal.load(Marshal.dump(%w{Brush up your Shakespeare}))
# => ["Brush", "up", "your", "Shakespeare"]

require 'set'
Marshal.load(Marshal.dump(Set.new([1, 2, 3])))
# => #<Set: {1, 2, 3}>
#---
Marshal.dump(Set)                          # =>"\004\010c\010Set"
#---
#!/usr/bin/ruby -w

Marshal.load("\004\010c\010Set")
# ArgumentError: undefined class/module Set
#---
open('output', 'w') { |f| Marshal.dump(f) }
# TypeError: can't dump File
#---
