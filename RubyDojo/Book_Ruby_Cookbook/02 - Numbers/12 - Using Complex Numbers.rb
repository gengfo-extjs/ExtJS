require 'complex'

Complex::I                                # => Complex(0, 1)

a = Complex(1, 4)                         # => Complex(1, 4)
a.real                                    # => 1
a.image                                   # => 4

b = Complex(1.5, 4.25)                    # => Complex(1.5, 4.25)
b + 1.5                                   # => Complex(3.0, 4.25)
b + 1.5*Complex::I                        # => Complex(1.5, 5.75)

a - b                                     # => Complex(-0.5, -0.25)
a * b                                     # => Complex(-15.5, 10.25)
b.conjugate                               # => Complex(1.5, -4.25)
Math::sin(b)
# => Complex(34.9720129257216, 2.47902583958724)
#---
class Mandelbrot

  # Set up the Mandelbrot generator with the basic parameters for 
  # deciding whether or not a point is in the set.
  def initialize(bailout=10, iterations=100)
    @bailout, @iterations = bailout, iterations    
  end  
#---
  # Performs the Mandelbrot operation @iterations times. If the
  # result exceeds @bailout, assume this point goes to infinity and
  # is not in the set. Otherwise, assume it is in the set.
  def mandelbrot(x, y)
    c = Complex(x, y)
    z = 0
    @iterations.times do |i|      
      z = z**2 + c                  # This is the Mandelbrot operation.
      return false if z > @bailout 
    end
    return true
  end
#---
  def render(x_size=80, y_size=24, inside_set="*", outside_set=" ")
    0.upto(y_size) do |y| 	
      0.upto(x_size) do |x|
        scaled_x = -2 + (3 * x / x_size.to_f)
        scaled_y = 1 + (-2 * y / y_size.to_f)
        print mandelbrot(scaled_x, scaled_y) ? inside_set : outside_set
      end
      puts
    end
  end
end
#---
Mandelbrot.new.render(25, 10)
#                **
#               ****
#             ********
#        *** *********
# *******************
#        *** *********
#             ********
#               ****
#                **
#---
