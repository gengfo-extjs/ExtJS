s = 'A string'
length_method = s.method('length') # => #<Method: String#length>
length_method.arity                # => 0
length_method.call                 # => 8
#---
1.succ                              # => 2
1.method(:succ).call                # => 2
#---
5.method('+').call(10)              # => 15


[1,2,3].method(:each).call { |x| puts x }
# 1
# 2
# 3
#---
class EventSpawner

  def initialize
    @listeners = []
    @state = 0
  end

  def subscribe(&listener)
    @listeners << listener
  end

  def change_state(new_state)   
    @listeners.each { |l| l.call(@state, new_state) }
    @state = new_state
  end
end

class EventListener
  def hear(old_state, new_state)
    puts "Method triggered: state changed from #{old_state} " +
      "to #{new_state}."
  end
end

spawner = EventSpawner.new
spawner.subscribe do |old_state, new_state| 
 puts "Block triggered: state changed from #{old_state} to #{new_state}." 
end


spawner.subscribe &EventListener.new.method(:hear) 
spawner.change_state(4)
# Block triggered: state changed from 0 to 4.
# Method triggered: state changed from 0 to 4.
#---
s = "sample string"
replacements = { "a" => "i", "tring" => "ubstitution" }

replacements.collect(&s.method("gsub"))
# => ["simple string", "sample substitution"]
#---
class Welcomer
 def Welcomer.a_class_method
   return "Greetings from the Welcomer class."
 end

 def an_instance_method
   return "Salutations from a Welcomer object."
 end
end

Welcomer.method("an_instance_method")           
# NameError: undefined method `an_instance_method' for class `Class'
Welcomer.new.method("an_instance_method").call  
# => "Salutations from a Welcomer object."
Welcomer.method("a_class_method").call         
# => "Greetings from the Welcomer class."
#---
