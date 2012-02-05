class Frog
  def initialize(name)
    @name = name    
  end

  def speak
    # It's a well-known fact that only frogs with long names start out
    # speaking English.
    @speaks_english ||= @name.size > 6
    @speaks_english ? "Hi. I'm #{@name}, the talking frog." : 'Ribbit.'
  end
end

Frog.new('Leonard').speak       # => "Hi. I'm Leonard, the talking frog."

lucas = Frog.new('Lucas')
lucas.speak                     # => "Ribbit."
#---
lucas.name
# NoMethodError: undefined method `name' for #<Frog:0xb7d0327c  @speaks_english=true, @name="Lucas">

class Frog
  attr_reader :name
end
lucas.name                      # => "Lucas"
#---
lucas.speaks_english = false
# => NoMethodError: undefined method `speaks_english=' for #<Frog:0xb7d0327c @speaks_english=false, @name="Lucas">

class Frog
  attr_accessor :speaks_english
end
lucas.speaks_english = true
lucas.speak                  # => "Hi. I'm Lucas, the talking frog."
#---
class Frog
  def speaks_english
    @speaks_english
  end

  def speaks_english=(value)
    @speaks_english = value
  end
end
#---
michael = Frog.new("Michael")
# => #<Frog:0xb7cf14c8 @name="Michael">
michael.speak                   # => "Hi. I'm Michael, the talking frog."
michael
# => #<Frog:0xb7cf14c8 @name="Michael", @speaks_english=true>
#---
michael.instance_variable_get("@name")          # => "Michael"
michael.instance_variable_set("@name", 'Bob')
michael.name                                    # => "Bob"

#---
class Frog
  define_method(:scientific_name) do 
    species = 'vulgaris'
    species = 'loquacious' if instance_variable_get('@speaks_english')
    "Rana #{species}"
  end
end
michael.scientific_name                        # => "Rana loquacious"
#---
