#!/usr/bin/ruby                                                  # 1 
# delegation.rb                                                  # 2 
class CEO                                                        # 3
  def CEO.new_vision                                             # 4
    Manager.implement_vision                                     # 5
  end                                                            # 6
end                                                              # 7
                                                                 # 8
class Manager                                                    # 9
  def Manager.implement_vision                                   # 10
    Engineer.do_work                                             # 11
  end                                                            # 12
end                                                              # 13
                                                                 # 14
class Engineer                                                   # 15
  def Engineer.do_work                                           # 16
    puts 'How did I get here?'                                   # 17
    first = true                                                 # 18
    caller.each do |c|                                           # 19
      puts %{#{(first ? 'I' : ' which')} was called by "#{c}"}   # 20
      first = false                                              # 21
    end                                                          # 22
  end                                                            # 23
end                                                              # 24
                                                                 # 25
CEO.new_vision                                                   # 26
#---
$ ./delegation.rb
How did I get here?
I was called by "delegation.rb:11:in `implement_vision'"
 which was called by "delegation.rb:5:in `new_vision'"
 which was called by "delegation.rb:26"
#---
def raise_exception
  raise Exception, 'You wanted me to raise an exception, so...'
end

begin
  raise_exception
rescue Exception => e
  puts "Backtrace of the exception:\n #{e.backtrace.join("\n ")}"
end
# Backtrace of the exception:
# (irb):2:in `raise_exception'
# (irb):5:in `irb_binding'
# /usr/lib/ruby/1.8/irb/workspace.rb:52:in `irb_binding'
# :0
#---
CALLER_RE = /(.*):([0-9]+)(:in \`(.*)')?/
def parse_caller(l)
  l.collect do |c|
    captures = CALLER_RE.match(c)
    [captures[1], captures[2], captures[4]]
  end
end

begin
  raise_exception
rescue Exception => e
  puts "Exception history:"
  first = true
  parse_caller(e.backtrace).each do |file, line, method|
    puts %{ #{first ? "L" : "because l"}ine #{line} in "#{file}"} +
         %{ called "#{method}" }
    first = false
  end
end
# Exception history:
#  Line 2 in "(irb)" called "raise_exception"
#  because line 24 in "(irb)" called "irb_binding"
#  because line 52 in "/usr/lib/ruby/1.8/irb/workspace.rb" called "irb_binding"
#  because line 0 in "" called ""
#---
