require 'aspectr'
class Verbose < AspectR::Aspect

 def describe(method_sym, object, *args)
    "#{object.inspect}.#{method_sym}(#{args.join(",")})"
  end

  def before(method_sym, object, return_value, *args)
    puts "About to call #{describe(method_sym, object, *args)}."
  end

  def after(method_sym, object, return_value, *args)
    puts "#{describe(method_sym, object, *args)} has returned " + 
      return_value.inspect + '.'
  end
end
#---
verbose = Verbose.new
stack = []
verbose.wrap(stack, :before, :after, :push, :pop)

stack.push(10)
# About to call [].push(10).
# [10].push(10) has returned [[10]].

stack.push(4)
# About to call [10].push(4).
# [10, 4].push(4) has returned [[10, 4]].

stack.pop
# About to call [10, 4].pop().
# [10].pop() has returned [4].
#---
class EvenMoreVerbose < AspectR::Aspect
  def useless(method_sym, object, return_value, *args)
    puts "More useless verbosity."
  end
end

more_verbose = EvenMoreVerbose.new
more_verbose.wrap(stack, :useless, nil, :push)
stack.push(60)
# About to call [10].push(60).
# More useless verbosity.
# [10, 60].push(60) has returned [[10, 60]].
#---
verbose.unwrap(stack, :before, :after, :push, :pop)
more_verbose.unwrap(stack, :useless, nil, :push)
stack.push(100)                             # => [10, 60, 100]
#---
