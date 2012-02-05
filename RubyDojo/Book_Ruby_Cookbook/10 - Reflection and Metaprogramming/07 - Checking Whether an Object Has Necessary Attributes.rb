class Object
  def must_have_instance_variables(*args)
    vars = instance_variables.inject({}) { |h,var| h[var] = true; h }
    args.each do |var|
      unless vars[var]
        raise ArgumentError, %{Instance variable "@#{var} not defined"} 
      end
    end
  end
end
#---
module LightEmitting
  def LightEmitting_setup
    must_have_instance_variables :light_color, :light_intensity
    @on = false
  end

  # Methods that use @light_color and @light_intensity follow...
end
#---
class Request
  def initialize
    gather_parameters # This is a virtual method defined by subclasses
    must_have_instance_variables :action, :user, :authentication
  end

  # Methods that use @action, @user, and @authentication follow...
end
#---
class Object
  def must_support(*args)
    args.each do |method| 
      unless respond_to? method
        raise ArgumentError, %{Must support "#{method}"}
      end
    end
  end
end

obj = "a string"
obj.must_support :to_s, :size, "+".to_sym
obj.must_support "+".to_sym, "-".to_sym
# ArgumentError: Must support "-"
#---
