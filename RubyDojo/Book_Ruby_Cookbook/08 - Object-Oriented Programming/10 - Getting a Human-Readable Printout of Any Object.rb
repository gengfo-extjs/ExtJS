a = [1,2,3]
puts a
# 1
# 2
# 3

puts a.to_s
# 123

puts a.inspect
# [1, 2, 3]
#---
puts /foo/
# (?-mix:foo)
puts /foo/.inspect
# /foo/
#---
f = File.open('foo', 'a')
puts f
# #<File:0xb7c31c30>
puts f.inspect
# #<File:foo>
#---
periodic_table = [{ :symbol => "H", :name => "hydrogen", :weight => 1.007 },
                  { :symbol => "Rg", :name => "roentgenium", :weight => 272 }]
puts periodic_table.inspect
# [{:symbol=>"H", :name=>"hydrogen", :weight=>1.007}, 
#  {:symbol=>"Rg", :name=>"roentgenium", :weight=>272}]

eval(periodic_table.inspect)[0]
# => {:symbol=>"H", :name=>"hydrogen", :weight=>1.007}
#---
class Dog
  def initialize(name, age)
    @name = name
    @age = age * 7 #Compensate for dog years
  end
end

spot = Dog.new("Spot", 2.1)
spot.inspect
# => "#<Dog:0xb7c16bec @name=\"Spot\", @age=14.7>"
#---
class Dog
  def inspect
    "<A Dog named #{@name} who's #{@age} in dog years.>"
  end

  def to_s
    inspect
  end
end
spot.inspect
# => "<A Dog named Spot who's 14.7 in dog years.>"
#---
class Dog
  def inspect
    %{Dog.new("#{@name}", #{@age/7})}
  end
end
spot.inspect
# => "Dog.new(\"Spot\", 2.1)"
eval(spot.inspect).inspect
# => "Dog.new(\"Spot\", 2.1)"
#---
strange_dog_name = %{Spot", 0); puts "Executing arbitrary Ruby..."; puts("}
spot = Dog.new(strange_dog_name, 0)
puts spot.inspect
# Dog.new("Spot", 0); puts "Executing arbitrary Ruby..."; puts("", 0)
eval(spot.inspect)
# Executing arbitrary Ruby...
# 
# 0
#---
