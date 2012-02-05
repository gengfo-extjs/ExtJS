class Person
  attr_reader :name, :age, :occupation

  def initialize(name, age, occupation)
    @name, @age, @occupation = name, age, occupation
  end    

  def mild_mannered?
    true
  end
end
#---
jimmy = Person.new('Jimmy Olsen', 21, 'cub reporter')
clark = Person.new('Clark Kent', 35, 'reporter')
jimmy.mild_mannered?                                     # => true
clark.mild_mannered?                                     # => true
#---
module SuperPowers
  def fly
    'Flying!'
  end

  def leap(what)    
    "Leaping #{what} in a single bound!"
  end

  def mild_mannered?
    false
  end

  def superhero_name
    'Superman'
  end
end
#---
clark.extend(SuperPowers)
clark.superhero_name                          # => "Superman"
clark.fly                                     # => "Flying!"
clark.mild_mannered?                          # => false
jimmy.mild_mannered?                          # => true
#---
class Person  
  extend SuperPowers
end

#which is equivalent to:
Person.extend(SuperPowers)
#---
Person.superhero_name                   # => "Superman"
Person.fly                              # => "Flying!"
#---
