require 'delegate'
class HexNumber < DelegateClass(Fixnum)
  # The string representations of this class are hexadecimal numbers.
  def to_s
    sign = self < 0 ? "-" : ""
    hex = abs.to_s(16)
    "#{sign}0x#{hex}"
  end

  def inspect
    to_s
  end
end

HexNumber.new(10)                             # => 0xa
HexNumber.new(-10)                            # => -0xa
HexNumber.new(1000000)                        # => 0xf4240
HexNumber.new(1024 ** 10)                     # => 0x10000000000000000000000000

HexNumber.new(10).succ                        # => 11
HexNumber.new(10) * 2                         # => 20
#---
100.object_id                                # => 201
(10 * 10).object_id                          # => 201
Fixnum.new(100)
# NoMethodError: undefined method `new' for Fixnum:Class
#---
(10 ** 20).object_id                         # => -606073730
((10 ** 19) * 10).object_id                  # => -606079360
Bignum.new(10 ** 20)
# NoMethodError: undefined method `new' for Bignum:Class
#---
HexNumber.new(10) * 2                         # => 20
HexNumber.new(10) + HexNumber.new(200)        # => 210
#---
require 'rubygems'
require 'facet/basicobject'

class BetterHexNumber < BasicObject

  def initialize(integer)
    @value = integer
  end  
  
  # Delegate all methods to the stored integer value. If the result is a
  # Integer, transform it into a BetterHexNumber object. If it's an
  # enumerable containing Integers, transform it into an enumerable
  # containing BetterHexNumber objects.
  def method_missing(m, *args)
    super unless @value.respond_to?(m)
    hex_args = args.collect do |arg| 
      arg.kind_of?(BetterHexNumber) ? arg.to_int : arg 
    end
    result = @value.send(m, *hex_args)
    return result if m == :coerce
    case result
    when Integer
      BetterHexNumber.new(result)
    when Array
      result.collect do |element|
        element.kind_of?(Integer) ? BetterHexNumber.new(element) : element
      end
    else
      result
    end
  end

  # We don't actually define any of the Fixnum methods in this class,
  # but from the perspective of an outside object we do respond to
  # them. What outside objects don't know won't hurt them, so we'll
  # claim that we actually implement the same methods as our delegate
  # object. Unless this method is defined, features like ranges won't
  # work.
  def respond_to?(method_name) 
    super or @value.respond_to? method_name 
  end
  
  # Convert the number to a hex string, ignoring any other base
  # that might have been passed in.
  def to_s(*args)
    hex = @value.abs.to_s(16)
    sign = self < 0 ? "-" : ""
    "#{sign}0x#{hex}"
  end

  def inspect
    to_s
  end
end
#---
hundred = BetterHexNumber.new(100)               # => 0x64
hundred + 5                                      # => 0x69
hundred + BetterHexNumber.new(5)                 # => 0x69
hundred.succ                                     # => 0x65
hundred / 5                                      # => 0x14
hundred * -10                                    # => -0x3e8
hundred.divmod(3)                                # => [0x21, 0x1]
(hundred...hundred+3).collect                    # => [0x64, 0x65, 0x66]
#---
hundred.class                                    # => Fixnum
hundred.respond_to? :succ                        # => true
hundred.is_a? Fixnum                             # => false
#---
