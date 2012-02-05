class Regexp
  def Regexp.is_valid?(str)
    begin
      compile(str)
      valid = true
    rescue RegexpError
      valid = false
    end
  end
end
Regexp.is_valid? "The horror!"                     # => true
Regexp.is_valid? "The)horror!"                     # => false

#---
def Fixnum.random(min, max)
  raise ArgumentError, "min > max" if min > max
  return min + rand(max-min+1)
end
Fixnum.random(10, 20)                             # => 13
Fixnum.random(-5, 0)                              # => -5
Fixnum.random(10, 10)                             # => 10
Fixnum.random(20, 10)                             
# ArgumentError: min > max
#---
company_name = 'Homegrown Software'
def company_name.legalese
  return "#{self} is a registered trademark of ConglomCo International."
end

company_name.legalese
# => "Homegrown Software is a registered trademark of ConglomCo International."
'Some Other Company'.legalese
# NoMethodError: undefined method `legalese' for "Some Other Company":String
#---
class Button
  #A stub method to be overridden by subclasses or individual Button objects
  def pushed
  end
end

buttonA = Button.new
def buttonA.pushed
  puts "You pushed me! I'm offended!"
end

buttonB = Button.new
def buttonB.pushed
  puts "You pushed me; that's okay."
end


Button.new.pushed
#

buttonA.pushed
# You pushed me! I'm offended!

buttonB.pushed
# You pushed me; that's okay.
#---
