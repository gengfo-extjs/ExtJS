class Tracker
  def important
    "This is an important method!"
  end 

  def self.method_added sym
    if sym == :important
      raise 'The "important" method has been redefined!'
    else
      puts %{Method "#{sym}" was (re)defined.}
    end
  end

  def self.method_removed sym
    if sym == :important
      raise 'The "important" method has been removed!'
    else
      puts %{Method "#{sym}" was removed.}
   end
  end

  def self.method_undefined sym
    if sym == :important
      raise 'The "important" method has been undefined!'
    else
      puts %{Method "#{sym}" was removed.}
    end
  end
end
#---
class Tracker
  def new_method
    'This is a new method.'
  end
end
# Method "new_method" was (re)defined.
#---
class Tracker
  undef :important
end
# RuntimeError: The "important" method has been undefined!
#---
class Tracker
  include Enumerable
end

# Nothing!
#---
class Module
 alias_method :include_no_hook, :include
 def include(*modules)
   # Run the old implementation.
   include_no_hook(*modules)
  
   # Then run the hook.
   modules.each do |mod|
     self.include_hook mod
   end
 end

 def include_hook
   # Do nothing by default, just like Module#method_added et al.
   # This method must be overridden in a subclass to do something useful.
 end
end
#---
class Tracker
  def self.include_hook mod
    puts %{"#{mod}" was included in #{self}.}
  end
end

class Tracker
  include Enumerable
end
# "Enumerable" was included in Tracker.
#---
