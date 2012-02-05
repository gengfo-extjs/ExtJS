'A string'.respond_to? :to_str              # => true
Exception.new.respond_to? :to_str           # => true
4.respond_to? :to_str                       # => false
#---
def join_to_successor(s)
  raise ArgumentError, 'No successor method!' unless s.respond_to? :succ
  return "#{s}#{s.succ}"
end

join_to_successor('a')                # => "ab"
join_to_successor(4)                  # => "45"
join_to_successor(4.01)
# ArgumentError: No successor method!
#---
