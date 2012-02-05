h = {}
h[1] = 10
h                                          # => {1=>10}
h.delete(1)
h                                          # => {}
#---
h = {}
h[5]                    # => nil
h[5] = 10
h[5]                    # => 10
h[5] = nil
h[5]                    # => nil
h.keys                  # => [5]
h.delete(5)
h.keys                  # => []
#---
class Hash
  def delete_value(value)
    delete_if { |k,v| v == value }
  end
end

h = {'apple' => 'green', 'potato' => 'red', 'sun' => 'yellow', 
     'katydid' => 'green' }
h.delete_value('green')
h                               # => {"sun"=>"yellow", "potato"=>"red"}
#---
class Hash
  def remove_hash(other_hash)
    delete_if { |k,v| other_hash[k] == v }
  end
end

squares = { 1 => 1, 2 => 4, 3 => 9 }
doubles = { 1 => 2, 2 => 4, 3 => 6 }
squares.remove_hash(doubles)
squares                                   # => {1=>1, 3=>9}
#---
h = {}
1.upto(1000) { |x| h[x] = x }
h.keys.size                               # => 1000
h.clear
h           # => {}
#---
