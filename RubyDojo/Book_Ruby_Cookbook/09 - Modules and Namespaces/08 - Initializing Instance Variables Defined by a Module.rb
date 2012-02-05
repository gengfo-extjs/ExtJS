module Timeable
 attr_reader :time_created

  def initialize
    @time_created = Time.now
  end

  def age      #in seconds
    Time.now - @time_created
  end
end
#---
class Character
  include Timeable
  attr_reader :name
  def initialize( name )
    @name = name
    super() #calls Timeable's initialize
  end
end

c = Character.new "Fred"
c.time_created
# => Mon Mar 27 18:34:31 EST 2006
#---
Character.ancestors               #  => [Character, Timeable, Object, Kernel]
#---
