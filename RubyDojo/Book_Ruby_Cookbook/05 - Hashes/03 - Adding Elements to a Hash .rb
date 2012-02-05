h = {}
h["Greensleeves"] = "all my joy"
h                                   # => {"Greensleeves"=>"all my joy"}
h["Greensleeves"] = "my delight"
h                                   # => {"Greensleeves"=>"my delight"}
#---
key = "Modify me if you can"
h = { key => 1 }
key.upcase!                         # => "MODIFY ME IF YOU CAN"
h[key]                              # => nil
h["Modify me if you can"]           # => 1

h.keys                              # => ["Modify me if you can"]
h.keys[0].upcase!                   
# TypeError: can't modify frozen string
#---
squares = [[1,1], [2,4], [3,9]]

results = {}
squares.each { |k,v| results[k] = v }
results                                             # => {1=>1, 2=>4, 3=>9}

squares.inject({}) { |h, kv| h[kv[0]] = kv[1]; h }  # => {1=>1, 2=>4, 3=>9}
#---
class Array
  def into_hash(h)
    unless size % 2 == 0
      raise StandardError, "Expected array with even number of elements"  
    end
    0.step(size-1, 2) { |x| h[self[x]] = self[x+1] }
    h
  end
end

squares = [1,1,2,3,4,9]
results = {}
squares.into_hash(results)                    # => {1=>1, 2=>3, 4=>9}

[1,1,2].into_hash(results)
# StandardError: Expected array with even number of elements
#---
squares = { 1 => 1, 2 => 4, 3 => 9}
cubes = { 3 => 27, 4 => 256, 5 => 3125}
squares.merge!(cubes)
squares                       # =>{5=>3125, 1=>1, 2=>4, 3=>27, 4=>256}
cubes                         # =>{5=>3125, 3=>27, 4=>256}
#---
squares = { 1 => 1, 2 => 4, 3 => 9}
cubes = { 1 => 1, 2 => 8, 3 => 27}
squares.replace(cubes)
squares    # => {1=>1, 2=>8, 3=>27}
#---
cubes[4] = 64
squares                     # => {1=>1, 2=>8, 3=>27}
#---
defaults = {:verbose => true, :help_level => :beginner }
args = {}
requests.each do |request|
  args.replace(defaults)
  request.process(args) #The process method might modify the args Hash.  
end  
#---
