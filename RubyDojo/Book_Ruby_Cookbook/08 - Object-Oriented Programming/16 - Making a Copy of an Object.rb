s1 = 'foo'                                       # => "foo"
s2 = s1.clone                                    # => "foo"
s1[0] = 'b'
[s1, s2]                                         # => ["boo", "foo"]
#---
material = 'cotton'
class << material
  def definition
     puts 'The better half of velour.'
  end
end

material.definition
# The better half of velour.

'cotton'.definition
# NoMethodError: undefined method `definition' for "cotton":String

material.clone.definition
# The better half of velour.

material.dup.definition               
# NoMethodError: undefined method `definition' for "cotton":String
#---
class StringHolder 
  attr_reader :string
  def initialize(string)
    @string = string
  end
end

s1 = StringHolder.new('string')
s2 = s1.dup
s3 = s1.clone

s1.string[1] = 'p'
s2.string                                      # => "spring"
s3.string                                      # => "spring"
#---
class Object
  def deep_copy
    Marshal.load(Marshal.dump(self))
  end
end

s1 = StringHolder.new('string')
s2 = s1.deep_copy
s1.string[1] = 'p'
s1.string                                     # => "spring"
s2.string                                     # => "string"
#---
class << s1
  def definition
     puts "We hold strings so you don't have to."
  end  
end
s1.deep_copy
# TypeError: singleton can't be dumped
#---
class StringHolder
  def initialize_copy(from)
   @string = from.string.dup
  end
end

s1 = StringHolder.new('string')
s2 = s1.dup
s3 = s1.clone

s1.string[1] = "p"
s2.string                                      # => "string"
s3.string                                      # => "string"
#---
