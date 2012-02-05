def send_as_package(obj)
  if obj.respond_to? :package
    packaged = obj.package
  else

    if $DEBUG
      $stderr.puts "Not sure how to package a #{obj.class}."
      $stderr.puts 'Trying generic packager.'
    end
    package = Package.new(obj)
  end
  send(package)
end
#---
def multiply_precisely(a, b)
  if a.is_a? Float or b.is_a? Float
    raise ArgumentError, "I can't do precise multiplication with floats."
  end
  a * b
end

multiply_precisely(4, 5)                                       # => 20
multiply_precisely(4.0, 5)
# ArgumentError: I can't do precise multiplication with floats.
#---
def append_to_self(x)
  unless x.respond_to? :<<
    raise ArgumentError, "This object doesn't support the left-shift operator."
  end
  if x.is_a? Numeric
    raise ArgumentError, 
	"The left-shift operator for this object doesn't do an append."
  end
  x << x
end 
  
append_to_self('abc')                             # => "abcabc"
append_to_self([1, 2, 3])                         # => [1, 2, 3, [...]]

append_to_self({1 => 2})
# ArgumentError: This object doesn't support the left-shift operator.

append_to_self(5)
# ArgumentError: The left-shift operator for this object doesn't do an append.
5 << 5                                                # => 160 
# That is, 5 * (2 ** 5)
#---
module ShiftMeansAppend
  def <<(x)
  end
end

class String
  include ShiftMeansAppend
end

class Array
  include ShiftMeansAppend
end

def append_to_self(x)
  unless x.is_a? ShiftMeansAppend
    raise ArgumentError, "I can't trust this object's left-shift operator."
  end
  x << x
end 

append_to_self 4
# ArgumentError: I can't trust this object's left-shift operator.


append_to_self '4'                            # => "44"
#---
