Math.log(1)                                    # => 0.0
Math.log(Math::E)                              # => 1.0
Math.log(10)                                   # => 2.30258509299405
Math::E ** Math.log(25)                        # => 25.0
#---
Math.log10(1)                                  # => 0.0
Math.log10(10)                                 # => 1.0
Math.log10(10.1)                               # => 1.00432137378264
Math.log10(1000)                               # => 3.0
10 ** Math.log10(25)                           # => 25.0
#---
module Math
  def Math.logb(num, base)
    log(num) / log(base)
  end
end
#---
dividend = Math.log(2)
(1..6).collect { |x| Math.log(x) / dividend }
# => [0.0, 1.0, 1.58496250072116, 2.0, 2.32192809488736, 2.58496250072116]
#---
require 'bigdecimal'
require 'bigdecimal/math'
require 'bigdecimal/util'

module BigMath
  alias :log_slow :log
  def log(x, prec)
    if x <= 0 || prec <= 0
      raise ArgumentError, "Zero or negative argument for log"
    end
    return x if x.infinite? || x.nan?
    sign, fraction, power, exponent = x.split
    fraction = BigDecimal(".#{fraction}")
    power = power.to_s.to_d
    log_slow(fraction, prec) + (log_slow(power, prec) * exponent)
  end
end
#---
include BigMath

number = BigDecimal("1234.5678")
Math.log(number)                        # => 7.11847622829779

prec = 50
BigMath.log_slow(number, prec).round(prec).to_s("F")
# => "7.11847622829778629250879253638708184134073214145175"
BigMath.log(number, prec).round(prec).to_s("F")
# => "7.11847622829778629250879253638708184134073214145175"
BigMath.log(number ** 1000, prec).round(prec).to_s("F")
# => "7118.47622829778629250879253638708184134073214145175161"
#---
huge_number = BigDecimal("1000") ** 1000
base = BigDecimal("10")
(BigMath.log(huge_number, 100) / BigMath.log(base, 100)).to_f
# => 3000.0
#---
