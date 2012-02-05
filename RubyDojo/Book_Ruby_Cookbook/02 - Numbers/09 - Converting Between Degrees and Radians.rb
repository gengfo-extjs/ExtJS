class Numeric
  def degrees
    self * Math::PI / 180 
  end
end
#---
90.degrees                                        # => 1.5707963267949
Math::tan(45.degrees)                             # => 1.0
Math::cos(90.degrees)                             # => 6.12303176911189e-17
Math::sin(90.degrees)                             # => 1.0
Math::sin(89.9.degrees)                           # => 0.999998476913288

Math::sin(45.degrees)                             # => 0.707106781186547
Math::cos(45.degrees)                             # => 0.707106781186548
#---
require 'rubygems'
require 'units/base'

class Numeric
  remove_method(:degrees) # Remove the implementation given in the Solution
  add_unit_conversions(:angle => { :radians => 1, :degrees => Math::PI/180 })
  add_unit_aliases(:angle => { :degrees => [:degree], :radians => [:radian] })
end

90.degrees                                        # => 90.0
90.degrees.unit                                   # => :degrees
90.degrees.to_radians                             # => 1.5707963267949
90.degrees.to_radians.unit                        # => :radians

1.degree.to_radians                               # => 0.0174532925199433
1.radian.to_degrees                               # => 57.2957795130823
#---
# Don't do this:
Math::sin(90.degrees)                                # => 0.893996663600558

# Do this:
Math::sin(90.degrees.to_radians)                     # => 1.0
#---
class << Math
  alias old_sin sin
  def sin(x)
    old_sin(x.unit == :degrees ? x.to_radians : x)
  end
end

90.degrees                                       # => 90.0
Math::sin(90.degrees)                            # => 1.0
Math::sin(Math::PI/2.radians)                    # => 1.0
Math::sin(Math::PI/2)                            # => 1.0
#---
