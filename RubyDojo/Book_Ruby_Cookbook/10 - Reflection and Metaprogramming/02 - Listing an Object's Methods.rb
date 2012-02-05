Object.methods
# => ["name", "private_class_method", "object_id", "new", 
#     "singleton_methods", "method_defined?", "equal?", ... ]
#---
Object.singleton_methods                       # => []
Fixnum.singleton_methods                       # => ["induced_from"]

class MyClass
  def MyClass.my_singleton_method
 end

  def my_instance_method
  end
end
MyClass.singleton_methods                      # => ["my_singleton_method"]
#---
''.methods == String.instance_methods          # => true
#---
Object.methods.sort
# => ["<", "<=", "<=>", "==", "===", "=~", ">", ">=",
#     "__id__", "__send__", "allocate", "ancestors", ... ]
#---
MyClass.method_defined? :my_instance_method   # => true
MyClass.new.respond_to? :my_instance_method   # => true
MyClass.respond_to? :my_instance_method       # => false

MyClass.respond_to? :my_singleton_method      # => true
#---
require 'irb/completion'
#Depending on your system, you may also have to add the following line:
IRB.conf[:use_readline] = true
#---
String.private_instance_methods.sort
# => ["Array", "Float", "Integer", "String", "`", "abort", "at_exit",
#     "autoload","autoload?", "binding", "block_given?", "callcc", ... ]
String.new.respond_to? :autoload?                   # => false

String.new.autoload?

# NoMethodError: private method `autoload?' called for "":String
#---
