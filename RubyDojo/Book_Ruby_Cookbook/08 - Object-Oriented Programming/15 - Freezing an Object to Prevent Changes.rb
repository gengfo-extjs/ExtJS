frozen_string = 'Brrrr!'
frozen_string.freeze
frozen_string.gsub('r', 'a')                      # => "Baaaa!"
frozen_string.gsub!('r', 'a')
# TypeError: can't modify frozen string
#---
sequences = [[1,2,3], [1,2,4], [1,4,9]].freeze
sequences << [2,3,5]
# TypeError: can't modify frozen array
sequences[2] << 16                               # => [1, 4, 9, 16]
#---
frozen_string.clone.frozen?                      # => true
frozen_string.dup.frozen?                        # => false
#---
frozen_string = 'A new string.'
frozen_string.frozen?                            # => false
#---
API_KEY = "100f7vo4gg".freeze

API_KEY[0] = 4
# TypeError: can't modify frozen string

API_KEY = "400f7vo4gg"
# warning: already initialized constant API_KEY
#---
class MyClass
  def my_method
    puts "This is the only method allowed in MyClass."
  end
  MyClass.freeze
end

class MyClass
  def my_method
    "I like this implementation of my_method better."
  end
end
# TypeError: can't modify frozen class

class MyClass
  def my_other_method
    "Oops, I forgot to implement this method."
  end
end
# TypeError: can't modify frozen class

class MySubclass < MyClass
  def my_method
    "This is only one of the methods available in MySubclass."
  end

  def my_other_method
    "This is the other one."
  end
end
MySubclass.new.my_method
# => "This is only one of the methods available in MySubclass."
#---
