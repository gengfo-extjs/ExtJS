def raise_and_rescue
  begin
    puts 'I am before the raise.'
    raise 'An error has occurred.'
    puts 'I am after the raise.'
  rescue
    puts 'I am rescued!'
  end
  puts 'I am after the begin block.'
end

raise_and_rescue
# I am before the raise.
# I am rescued!
# I am after the begin block.
#---
def do_it(code)
  eval(code)
rescue 
  puts "Cannot do it!"
end

do_it('puts 1 + 1')
# 2

do_it('puts 1 +')
# SyntaxError: (eval):1:in `do_it': compile error
#---
def do_it(code)
  eval(code)
rescue SyntaxError
  puts "Cannot do it!"
end

do_it('puts 1 +')
# Cannot do it!
#---
begin
 # ...
rescue OneTypeOfException
 # ...
rescue AnotherTypeOfException
 # ...
end
#---
begin
  raise 'A test exception.'
rescue Exception => e
  puts e.message
  puts e.backtrace.inspect
end
# ["(irb):33:in `irb_binding'", 
#  "/usr/lib/ruby/1.8/irb/workspace.rb:52:in `irb_binding'", 
#  ":0"]
#---
require 'English'
begin
  raise 'Another test exception.'
rescue Exception 
  puts $!.message
  puts $ERROR_INFO.message
end
# Another test exception.
# Another test exception.
#---
