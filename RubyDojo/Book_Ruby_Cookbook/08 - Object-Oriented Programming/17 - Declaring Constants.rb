not_a_constant = 3
not_a_constant = 10

A_CONSTANT = 3
A_CONSTANT = 10
# warning: already initialized constant A_CONSTANT
#---
CONST = 4

module ConstModule
  CONST = 6
end

class ConstHolder
  CONST = 8

  def my_const
    return CONST
  end
end

CONST                        # => 4
ConstModule::CONST           # => 6
ConstHolder::CONST           # => 8
ConstHolder.new.my_const     # => 8
#---
E = 2.718281828               # => 2.718281828
E = 6                       
# warning: already initialized constant E
E                             # => 6
#---
# This should make things a lot simpler.
module Math
 remove_const(:PI)
  PI = 3
end
Math::PI                                        # => 3
#---
RGB_COLORS = [:red, :green, :blue]        # => [:red, :green, :blue]
RGB_COLORS << :purple                     # => [:red, :green, :blue, :purple]

RGB_COLORS = [:red, :green, :blue] 
# warning: already initialized constant RGB_GOLORS
RGB_COLORS                                # => [:red, :green, :blue]

RGB_COLORS.freeze
RGB_COLORS << :purple
# TypeError: can't modify frozen array
#---
HOURS_PER_DAY = 24
HOURS_PER_DAY.freeze # This does nothing since Fixnums are already immutable.

HOURS_PER_DAY = 26
# warning: already initialized constant HOURS_PER_DAY
HOURS_PER_DAY                            # => 26
#---
