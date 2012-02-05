module Contracts
  def valid_contract(input)
    if @user_defined and @user_defined[input]
      @user_defined[input]
    else
      case input
      when :number
        lambda { |x| x.is_a? Numeric }
      when :string
        lambda { |x| x.respond_to? :to_str }
      when :anything
        lambda { |x| true }
      else
        lambda { |x| false }
      end
    end
  end

  class ContractViolation < StandardError
  end 
  
  def define_data(inputs={}.freeze)
    @user_defined ||= {}
    inputs.each do |name, contract|
      @user_defined[name] = contract if contract.respond_to? :call
    end
  end

  def contract(method, *inputs)
    @contracts ||= {}
    @contracts[method] = inputs
    method_added(method)
  end
 
  def setup_contract(method, inputs)
    @contracts[method] = nil
    method_renamed = "__#{method}".intern
    
    conditions = ""
    inputs.flatten.each_with_index do |input, i|
      conditions << %{
       if not self.class.valid_contract(#{input.inspect}).call(args[#{i}])
          raise ContractViolation, "argument #{i+1} of method '#{method}' must satisfy the '#{input}' contract", caller
        end
      }
    end

   class_eval %{
       alias_method #{method_renamed.inspect}, #{method.inspect}
       def #{method}(*args)
         #{conditions}
         return #{method_renamed}(*args)
       end
     }
  end

  def method_added(method)
    inputs = @contracts[method]
    setup_contract(method, inputs) if inputs
  end
end


#---
class TestContracts

  def hello(n, s, f)
    n.times { f.write "hello #{s}!\n" }
  end
#---
  extend Contracts
  
  writable_and_open = lambda do |x| 
    x.respond_to?('write') and x.respond_to?('closed?') and not x.closed?
  end

  define_data(:writable => writable_and_open,
              :positive => lambda {|x| x >= 0 })
#---
  contract :hello, [:positive, :string, :writable]
end
#---
tc = TestContracts.new
tc.hello(2, 'world', $stdout)
# hello world!
# hello world!

tc.hello(-1, 'world', $stdout)
# Contracts::ContractViolation: argument 1 of method 'hello' must satisfy the
# 'positive' contract

tc.hello(2, 3001, $stdout)
# test-contracts.rb:22: argument 2 of method 'hello' must satisfy the 
# 'string' contract (Contracts::ContractViolation)

closed_file = open('file.txt', 'w') { }
tc.hello(2, 'world', closed_file)
# Contracts::ContractViolation: argument 3 of method 'hello' must satisfy the 
# 'writable' contract
#---
contract :hello, [:positive, :string, :writable]
#---
def hello(n,s,f)
  if not (n >= 0)
    raise ContractViolation, 
    "argument 1 of method 'hello' must satisfy the 'positive' contract", caller
  end
  if not (s.respond_to? String)
    raise ContractViolation,
    "argument 2 of method 'hello' must satisfy the 'string' contract", 
    caller
  end
  if not (f.respond_to?('write') and f.respond_to?('closed?') 
          and not f.closed?)
    raise ContractViolation, 
    "argument 3 of method 'hello' must satisfy the 'writable' contract",
    caller
  end
  return __hello(n,s,f)
end

def __hello(n,s,f)
  n.times { f.write "hello #{s}!\n" }
end
#---
