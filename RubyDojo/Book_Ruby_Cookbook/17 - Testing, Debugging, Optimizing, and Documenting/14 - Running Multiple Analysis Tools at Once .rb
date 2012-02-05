# multitrace.rb
$TRACE_FUNCS = []

alias :set_single_trace_func :set_trace_func
def set_trace_func(proc)
  if (proc == nil)
    $TRACE_FUNCS.clear
  else
    $TRACE_FUNCS << proc
  end
end

trace_all = Proc.new do |event, file, line, symbol, binding, klass|
  $TRACE_FUNCS.each { |p| p.call(event, file, line, symbol, binding, klass)}
end
set_single_trace_func trace_all

def unset_trace_func(proc)
  $TRACE_FUNCS.delete(proc)
end
#---
#!/usr/bin/ruby
# paranoia.rb
require 'multitrace'
require 'profile'
require 'tracer'

Tracer.on
puts "I feel like I'm being watched."
#---
$ ruby paranoia.rb
#0:./multitrace.rb:9:Array:<:     $TRACE_FUNCS << proc
#0:./multitrace.rb:11:Object:<: end
#0:paranoia.rb:9::-: puts "I feel like I'm being watched."
#0:paranoia.rb:9:Kernel:>: puts "I feel like I'm being watched."
...
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
  0.00     0.00     0.00        1     0.00     0.00  Kernel.require
  0.00     0.00      0.00     1     0.00     0.00  Fixnum#==
  0.00     0.00      0.00        1     0.00    0.00  String#scan
...
#---
