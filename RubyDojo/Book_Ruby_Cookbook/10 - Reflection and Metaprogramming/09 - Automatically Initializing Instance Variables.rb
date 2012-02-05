class RGBColor(red=0, green=0, blue=0)
  @red = red
  @green = green
  @blue = blue
end
#---
class Object
  private
  def set_instance_variables(binding, *variables)
    variables.each do |var| 
      eval("@#{var} = #{var}", binding)
    end
	#instance_variable_set("@#{var}", var)
  end
end 
#---
class RGBColor
  def initialize(red=0, green=0, blue=0)
    set_instance_variables(binding, *local_variables)
  end
end

RGBColor.new(10, 200, 300)
# => #<RGBColor:0xb7c22fc8 @red=10, @blue=300, @green=200>
#---
class RGBColor
  def initialize(red=0, green=0, blue=0, debug=false)
    set_instance_variables(binding, *local_variables-['debug'])
    puts "Color: #{red}/#{green}/#{blue}" if debug
  end
end

RGBColor.new(10, 200, 255, true)
# Color: 10/200/255
# => #<RGBColor:0xb7d309fc @blue=255, @green=200, @red=10>
#---
