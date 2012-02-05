class Object
  def my_methods_only
    my_super = self.class.superclass
    return my_super ? methods - my_super.instance_methods : methods
  end
end

s = ''
s.methods.size                              # => 143
Object.instance_methods.size                # =>  41
s.my_methods_only.size                      # => 102
(s.methods - Object.instance_methods).size  # => 102

def s.singleton_method()
end
s.methods.size                              # => 144
s.my_methods_only.size                      # => 103

class Object
  def new_object_method
  end
end
s.methods.size                              # => 145
s.my_methods_only.size                      # => 103

class MyString < String
  def my_string_method
  end
end
MyString.new.my_methods_only                # => ["my_string_method"]
#---
class Object
  def my_methods_only_no_mixins
    m = my_methods_only
    self.class.ancestors.each do |ancestor| 
    m = m - ancestor.instance_methods unless ancestor.is_a?(Class) \
	 || ancestor == Kernel      
    end
    return m
  end  
end

[].methods.size                                    # => 121
[].my_methods_only.size                            # => 78
[].my_methods_only_no_mixins.size                  # => 57
#---
