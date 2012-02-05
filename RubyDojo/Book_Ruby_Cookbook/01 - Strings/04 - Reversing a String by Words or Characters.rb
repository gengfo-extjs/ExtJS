s = ".sdrawkcab si gnirts sihT"
s.reverse                             # => "This string is backwards."
s                                     # => ".sdrawkcab si gnirts sihT"

s.reverse!                            # => "This string is backwards."
s                                     # => "This string is backwards."
#---
s = "order. wrong the in are words These"
s.split(/(\s+)/).reverse!.join('')   # => "These words are in the wrong order."
s.split(/\b/).reverse!.join('')      # => "These words are in the wrong. order"
#---
"Three little  words".split(/\s+/)   # => ["Three", "little", "words"]
"Three little  words".split(/(\s+)/) 
# => ["Three", " ", "little", "  ", "words"]
#---
