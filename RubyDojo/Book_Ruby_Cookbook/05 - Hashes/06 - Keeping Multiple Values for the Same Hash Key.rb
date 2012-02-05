hash = Hash.new { |hash, key| hash[key] = [] }

raw_data = [ [1, 'a'], [1, 'b'], [1, 'c'], 
             [2, 'a'], [2, ['b', 'c']],
             [3, 'c'] ]
raw_data.each { |x,y| hash[x] << y }
hash 
# => {1=>["a", "b", "c"], 2=>["a", ["b", "c"]], 3=>["c"]}
#---
class MultiValuedHash < Hash
  def []=(key, value)
    if has_key?(key)      
      super(key, [value, self[key]].flatten)
    else
      super
    end  
  end
end

hash = MultiValuedHash.new
raw_data.each { |x,y|  hash[x] = y }
hash
# => {1=>["c", "b", "a"], 2=>["b", "c", "a"], 3=>"c"}
#---
