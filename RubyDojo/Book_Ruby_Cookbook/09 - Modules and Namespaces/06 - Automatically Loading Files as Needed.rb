# functions.rb
module Decidable
  # ... Many, many methods go here.
end

module Semidecidable
  # ... Many, many methods go here.
end
#---
# functions.rb
autoload :Decidable, "decidable.rb"
autoload :Semidecidable, "semidecidable.rb"
#---
# decidable.rb
module Decidable
  # ... Many, many methods go here.
end
#---
# semidecidable.rb
module Semidecidable
  # ... Many, many methods go here.
end
#---
require 'functions'
Decidable.class                                # => Module
# More use of the Decidable module follows...
#---
autoload :Set, "set.rb"

def random_set(size)
  max = size * 10
  set = Set.new
  set << rand(max) until set.size == size
  return set
end

# More code goes here...
#---
random_set(10)
# => #<Set: {39, 83, 73, 40, 90, 25, 91, 31, 76, 54}>

require 'set'                                            # => false
#---
