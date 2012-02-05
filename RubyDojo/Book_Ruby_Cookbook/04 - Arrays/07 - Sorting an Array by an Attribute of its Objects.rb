[5.01, -5, 0, 5].sort                    # => [-5, 0, 5, 5.01]
["Utahraptor", "Ankylosaur", "Maiasaur"].sort   
# => ["Ankylosaur", "Maiasaur", "Utahraptor"]
#---
arrays = [[1,2,3], [100], [10,20]]
arrays.sort_by { |x| x.size }            # => [[100], [10, 20], [1, 2, 3]]

#---
[1, 100, 42, 23, 26, 10000].sort do |x, y| 
  x == 42 ? 1 :  x <=> y
end
# => [1, 23, 26, 100, 10000, 42]
#---
class Animal
 attr_reader :name, :eyes, :appendages

 def initialize(name, eyes, appendages)
  @name, @eyes, @appendages = name, eyes, appendages
 end

 def inspect
  @name
 end
end

animals = [Animal.new("octopus", 2, 8), 
           Animal.new("spider", 6, 8),
           Animal.new("bee", 5, 6),
           Animal.new("elephant", 2, 4),
           Animal.new("crab", 2, 10)]

animals.sort_by { |x| x.eyes }
# => [octopus, elephant, crab, bee, spider]

animals.sort_by { |x| x.appendages  }
# => [elephant, bee, octopus, spider, crab]
#---
