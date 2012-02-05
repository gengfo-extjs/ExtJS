float = 2.0/3.0                                # => 0.666666666666667
float * 100                                    # => 66.6666666666667
float * 100 / 42                               # => 1.58730158730159

require 'rational'
rational = Rational(2, 3)                      # => Rational(2, 3)
rational.to_f                                  # => 0.666666666666667
rational * 100                                 # => Rational(200, 3)
rational * 100 / 42                            # => Rational(100, 63)
#---
10 + Rational(2,3)                       # => Rational(32, 3)
require 'bigdecimal'
BigDecimal('10') + Rational(2,3)         # => 10.6666666666667
#---
Math::sqrt(Rational(2,3))                      # => 0.816496580927726
Math::sqrt(Rational(25,1))                     # => 5.0
Math::log10(Rational(100, 1))                  # => 2.0
#---
require 'mathn'
Math::sqrt(Rational(2,3))                      # => 0.816496580927726
Math::sqrt(Rational(25,1))                     # => 5
Math::sqrt(25)                                 # => 5
Math::sqrt(25.0)                               # => 5.0
#---
