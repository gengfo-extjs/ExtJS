module MyLib
  module ClassMethods
    def class_method
      puts "This method was first defined in MyLib::ClassMethods"
    end
  end
end
#---
module MyLib
  def self.included(receiver)
    puts "MyLib is being included in #{receiver}!"
    receiver.extend(ClassMethods)
  end
end
#---
class MyClass
  include MyLib
end
# MyLib is being included in MyClass!

MyClass.class_method
# This method was first defined in MyLib::ClassMethods
#---
