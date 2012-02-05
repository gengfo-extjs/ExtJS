def broken_print_variable(var_name)
  eval %{puts "The value of #{var_name} is " + #{var_name}.to_s}
end
#---
tin_snips = 5

broken_print_variable('tin_snips')
# NameError: undefined local variable or method `tin_snips' for main:Object

var_name = 'tin_snips'
eval %{puts "The value of #{var_name} is " + #{var_name}.to_s}
# The value of tin_snips is 5
#---
def print_variable(var_name, binding)
  eval %{puts "The value of #{var_name} is " + #{var_name}.to_s}, binding
end

vice_grips = 10
print_variable('vice_grips', binding)
# The value of vice_grips is 10
#---
