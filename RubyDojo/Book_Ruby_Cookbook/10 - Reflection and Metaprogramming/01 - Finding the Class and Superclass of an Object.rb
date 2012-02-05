'a string'.class                                  # => String
'a string'.class.name                             # => "String"
'a string'.class.superclass                       # => Object
String.superclass                                 # => Object
String.class                                      # => Class
String.class.superclass                           # => Module
'a string'.class.new                              # => ""
#---
class Class
  def hierarchy
    (superclass ? superclass.hierarchy : []) << self
  end
end

Array.hierarchy        # => [Object, Array]

class MyArray < Array
end
MyArray.hierarchy      # => [Object, Array, MyArray]
#---
String.superclass         # => Object
String.ancestors          # => [String, Enumerable, Comparable, Object, Kernel]
Array.ancestors           # => [Array, Enumerable, Object, Kernel]
MyArray.ancestors         # => [MyArray, Array, Enumerable, Object, Kernel]

Object.ancestors          # => [Object, Kernel]

class MyClass
end
MyClass.ancestors         # => [MyClass, Object, Kernel]
#---
