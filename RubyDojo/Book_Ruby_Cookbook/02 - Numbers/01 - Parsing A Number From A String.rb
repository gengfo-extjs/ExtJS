'400'.to_i                      # => 400
'3.14'.to_f                     # => 3.14
'1.602e-19'.to_f                # => 1.602e-19
#---
'405'.oct                       # => 261
'405'.to_i(8)                   # => 261
'405'.hex                       # => 1029
'405'.to_i(16)                  # => 1029
'fed'.hex                       # => 4077
'fed'.to_i(16)                  # => 4077
#---
"13: a baker's dozen".to_i                          # => 13
'1001 Nights'.to_i                                  # => 1001
'The 1000 Nights and a Night'.to_i                  # => 0
'60.50  Misc. Agricultural Equipment'.to_f          # => 60.5
'$60.50'.to_f                                       # => 0.0
'Feed the monster!'.hex                             # => 65261
'I fed the monster at Canoga Park Waterslides'.hex  # => 0
'0xA2Z'.hex                                         # => 162
'-10'.oct                                           # => -8
'-109'.oct                                          # => -8
'3.14'.to_i                                         # => 3
#---
Integer('1001')                                     # => 1001
Integer('1001 nights')
# ArgumentError: invalid value for Integer: "1001 nights"

Float('99.44')                                       # => 99.44
Float('99.44% pure')
# ArgumentError: invalid value for Float(): "99.44% pure"
#---
class NumberParser
  @@number_regexps = { 
    :to_i => /([+-]?[0-9]+)/,
    :to_f => /([+-]?([0-9]*\.)?[0-9]+(e[+-]?[0-9]+)?)/i,
    :oct => /([+-]?[0-7]+)/,
    :hex => /\b([+-]?(0x)?[0-9a-f]+)\b/i
    #The \b characters prevent every letter A-F in a word from being
    #considered a hexadecimal number.
  }

  def NumberParser.re(parsing_method=:to_i)
    re = @@number_regexps[parsing_method] 
    raise ArgumentError, "No regexp for #{parsing_method.inspect}!" unless re
    return re
  end

  def extract(s, parsing_method=:to_i)
    numbers = []
    s.scan(NumberParser.re(parsing_method)) do |match| 
      numbers << match[0].send(parsing_method) 
    end
    numbers
  end
end
#---
p = NumberParser.new

pw = "Today's numbers are 104 and 391."
NumberParser.re(:to_i).match(pw).captures                 # => ["104"]
p.extract(pw, :to_i)                                      # => [104, 391]

p.extract('The 1000 nights and a night')                  # => [1000]
p.extract('$60.50', :to_f)                                # => [60.5]
p.extract('I fed the monster at Canoga Park Waterslides', :hex)
# => [4077]
p.extract('In octal, fifteen is 017.', :oct)              # => [15]

p.extract('From 0 to 10e60 in -2.4 seconds', :to_f)
# => [0.0, 1.0e+61, -2.4]
p.extract('From 0 to 10e60 in -2.4 seconds')
# => [0, 10, 60, -2, 4]
#---
require 'scanf'
s = '0x10 4.44 10'.scanf('%x %f %d')                     # => [16, 4.44, 10]
#---
