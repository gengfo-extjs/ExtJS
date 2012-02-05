class Shape2D
  def area
    raise NotImplementedError.
      new("#{self.class.name}#area is an abstract method.")
  end
end


Shape2D.new.area
# NotImplementedError: Shape2D#area is an abstract method.
#---
class Square < Shape2D
  def initialize(length)
    @length = length
  end

  def area
    @length ** 2
  end
end

Square.new(10).area                              # => 100
#---
class Shape2D
  def initialize
    raise NotImplementedError.
      new("#{self.class.name} is an abstract class.")
  end
end

Shape2D.new
# NotImplementedError: Shape2D is an abstract class.
#---
class Class
  def abstract(*args)
    args.each do |method_name|

      define_method(method_name) do |*args|
        if method_name == :initialize
          msg = "#{self.class.name} is an abstract class."
        else
          msg = "#{self.class.name}##{method_name} is an abstract method."
        end
        raise NotImplementedError.new(msg)

     end
    end
  end
end

#---
class Animal
  abstract :initialize, :move
end


Animal.new
# NotImplementedError: Animal is an abstract class.
#---
class Sponge < Animal
  def initialize
    @type = :Sponge
  end
end


sponge = Sponge.new
sponge.move
# NotImplementedError: Sponge#move is an abstract method.
#---
class Cheetah < Animal
  def initialize
    @type = :Cheetah
  end

  def move
    "Running!"
  end
end

Cheetah.new.move
# => "Running!"
#---
class Sponge
  def move
    "Floating on ocean currents!"
  end
end
sponge.move
# => "Floating on ocean currents!"
#---
