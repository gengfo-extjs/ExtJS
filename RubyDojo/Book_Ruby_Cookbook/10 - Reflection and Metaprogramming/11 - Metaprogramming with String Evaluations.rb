class Numeric
 [['add', '+'], ['subtract', '-'], 
  ['multiply', '*',], ['divide', '/']].each do |method, operator|
    define_method("#{method}_2") do
      method(operator).call(2)
    end
  end
end
#---
class Numeric
  [['add', '+'], ['subtract', '-'], 
   ['multiply', '*',], ['divide', '/']].each do |method, operator|
    module_eval %{ def #{method}_2
                     self #{operator} 2
                   end }
  end
end

4.add_2                                                  # => 6
10.divide_2                                              # => 5
#---
class String
  def last(n)
    self[-n, n]
  end
end
"Here's a string.".last(7)               # => "string."

class String
  define_method('last') do |n|
   self[-n, n]
  end
end
"Here's a string.".last(7)               # => "string."

class String
  module_eval %{def last(n)
                  self[-n, n]
                end}
end
"Here's a string.".last(7)               # => "string."

String.module_eval %{def last(n)
                       self[-n, n]
                     end}

"Here's a string.".last(7)               # => "string."
#---
class String
  eval %{def last(n)
           self[-n, n]
         end}
end
"Here's a string.".last(7)               # => "string."
#---
