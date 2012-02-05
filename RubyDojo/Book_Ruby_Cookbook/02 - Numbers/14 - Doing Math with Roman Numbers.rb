class Roman
  # These arrays map all distinct substrings of Roman numbers
  # to their Arabic equivalents, and vice versa.
  @@roman_to_arabic = [['M', 1000], ['CM', 900], ['D', 500], ['CD', 400], 
    ['C', 100], ['XC', 90], ['L', 50], ['XL', 40], ['X', 10], ['IX', 9], 
    ['V', 5], ['IV', 4], ['I', 1]]
  @@arabic_to_roman = @@roman_to_arabic.collect { |x| x.reverse }.reverse

  # The Roman symbol for 5000 (a V with a bar over it) is in neither
  # ASCII nor Unicode, so we won't represent numbers larger than 3999.
  MAX = 3999

  def initialize(number)
    if number.respond_to? :to_str
      @value = Roman.to_arabic(number)
    else
      Roman.assert_within_range(number)
      @value = number
    end
  end  

  # Raise an exception if a number is too large or small to be represented
  # as a Roman number.
  def Roman.assert_within_range(number)
    unless number.between?(1, MAX)
      msg = "#{number} can't be represented as a Roman number."
      raise RangeError.new(msg)
    end
  end

  #Find the Fixnum value of a string containing a Roman number.
  def Roman.to_arabic(s)
    value = s
    if s.respond_to? :to_str
      c = s.dup
      value = 0
      invalid = ArgumentError.new("Invalid Roman number: #{s}")
      value_of_previous_number = MAX+1
      value_from_previous_number = 0
      @@roman_to_arabic.each_with_index do |(roman, arabic), i|
        value_from_this_number = 0
        while c.index(roman) == 0
          value_from_this_number += arabic
          if value_from_this_number >= value_of_previous_number
            raise invalid
          end
          c = c[roman.size..s.size]
        end
        
        #This one's a little tricky. We reject numbers like "IVI" and
        #"IXV", because they use the subtractive notation and then
        #tack on a number that makes the total overshoot the number
        #they'd have gotten without using the subtractive
        #notation. Those numbers should be V and XIV, respectively.
        if i > 2 and @@roman_to_arabic[i-1][0].size > 1 and 
            value_from_this_number + value_from_previous_number >= 
            @@roman_to_arabic[i-2][1]
          raise invalid
        end
        
        value += value_from_this_number
        value_from_previous_number = value_from_this_number
        value_of_previous_number = arabic
        break if c.size == 0
      end
      raise invalid if c.size > 0
    end
    return value
  end
  
  def to_arabic
    @value
  end
  
  #Render a Fixnum as a string depiction of a Roman number
  def to_roman
    value = to_arabic
    Roman.assert_within_range(value)
    repr = ""
    @@arabic_to_roman.reverse_each do |arabic, roman|
      num, value = value.divmod(arabic)
      puts "Roman #{roman} num #{num}"
      repr << roman * num
    end
    repr
  end  
#---
  # Delegate all methods to the stored integer value. If the result is
  # a Integer, transform it into a Roman object. If it's an array
  # containing Integers, transform it into an array containing Roman
  # objects.
  def method_missing(m, *args)
    super unless @value.respond_to?(m)
    hex_args = args.collect do |arg| 
      arg.kind_of?(Roman) ? arg.to_int : arg 
    end
    result = @value.send(m, *hex_args)
    return result if m == :coerce
    begin
      case result     
      when Integer
        Roman.new(result)
      when Array
        result.collect do |element|
          element.kind_of?(Integer) ? Roman.new(element) : element
        end
      else
        result
      end
    rescue RangeError
      # Too big or small to fit in a Roman number. Use the Fixnum.
      result
    end
  end
#---
  def respond_to?(method_name) 
    super or @value.respond_to? method_name 
  end

  def to_s
    to_roman
  end

  def inspect
    to_s
  end
end
#---
class Fixnum
  def to_roman
    Roman.new(self)
  end
end

class String
  def to_roman
    Roman.new(self)
  end
end
#---
72.to_roman                                    # => LXXII
444.to_roman                                   # => CDXLIV
1979.to_roman                                  # => MCMLXXIX
'MCMXLVIII'.to_roman                           # => MCMXLVIII

Roman.to_arabic('MCMLXXIX')                    # => 1979
'MMI'.to_roman.to_arabic                       # => 2001

'MMI'.to_roman + 3                             # => MMIV
'MCMXLVIII'.to_roman                           # => MCMXLVIII
612.to_roman * 3.to_roman                      # => MDCCCXXXVI
(612.to_roman * 3).divmod('VII'.to_roman)      # => [CCLXII, II]
612.to_roman * 10000                           # => 6120000    # Too big
612.to_roman * 0                               # => 0          # Too small

'MCMXCIX'.to_roman.succ                        # => MM

('I'.to_roman..'X'.to_roman).collect
# => [I, II, III, IV, V, VI, VII, VIII, IX, X]
#---
'IIII'.to_roman
# ArgumentError: Invalid Roman number: IIII
'IVI'.to_roman
# ArgumentError: Invalid Roman number: IVI
'IXV'.to_roman
# ArgumentError: Invalid Roman number: IXV
'MCMM'.to_roman
# ArgumentError: Invalid Roman number: MCMM
'CIVVM'.to_roman
# ArgumentError: Invalid Roman number: CIVVM
-10.to_roman
# RangeError: -10 can't be represented as a Roman number.
50000.to_roman
# RangeError: 50000 can't be represented as a Roman number.
#---
<ol style="list-style-type:lower-roman">
<li>Primus</li>
<li>Secundis</li>
<li>Tertius</li>
</ol>
#---
