# The Rectangle constructor accepts arguments in either of the following forms:
#  Rectangle.new([x_top, y_left], length, width)
#  Rectangle.new([x_top, y_left], [x_bottom, y_right])
class Rectangle
  def initialize(*args) 
    case args.size 
    when 2
      @top_left, @bottom_right = args
    when 3
      @top_left, length, width = args
      @bottom_right = [@top_left[0] + length, @top_left[1] - width]
    else
      raise ArgumentError, "This method takes either 2 or 3 arguments."
    end

    # Perform additional type/error checking on @top_left and
    # @bottom_right...
  end
end

#---
Rectangle.new([10, 23], [14, 13])
# => #<Rectangle:0x2d3098 @bottom_right=[14, 13], @top_left=[10, 23]>

Rectangle.new([10, 23], 4, 10)
# => #<Rectangle:0x2d0550 @bottom_right=[14, 13], @top_left=[10, 23]>

Rectangle.new
# ArgumentError: This method takes either 2 or 3 arguments.
#---
