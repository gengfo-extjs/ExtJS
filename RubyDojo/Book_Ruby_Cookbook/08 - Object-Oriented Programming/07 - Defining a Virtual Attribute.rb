class Arc
  attr_accessor :radians

  def degrees
    @radians * 180 / Math::PI
  end

  def degrees=(degrees)
    @radians = degrees * Math::PI / 180
  end
end

arc = Arc.new
arc.degrees = 180
arc.radians                                  # => 3.14159265358979
arc.radians = Math::PI / 2
arc.degrees                                  # => 90.0
#---
