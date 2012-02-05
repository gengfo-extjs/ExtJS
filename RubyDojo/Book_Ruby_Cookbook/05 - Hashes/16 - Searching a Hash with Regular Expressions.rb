h = { "apple tree" => "plant", "ficus" => "plant", 
      "shrew" => "animal", "plesiosaur" => "animal" }
h.keys.grep /p/                 
# => ["apple tree", "plesiosaur"]
#---
h.inject([]) { |res, kv| res << kv if kv[1] =~ /p/; res }
# => [["ficus", "plant"], ["apple tree", "plant"]]
#---
class Hash
  def grep(pattern)
    inject([]) do |res, kv| 
      res << kv if kv[0] =~ pattern or kv[1] =~ pattern
      res
    end
  end
end

h.grep(/pl/)          
# => [["ficus", "plant"], ["apple tree", "plant"], ["plesiosaur", "animal"]]
h.grep(/plant/)        # => [["ficus", "plant"], ["apple tree", "plant"]]
h.grep(/i.*u/)         # => [["ficus", "plant"], ["plesiosaur", "animal"]]
#---
res = []
h.each_key { |k| res << k if k =~ /p/ }
res                   # => ["apple tree", "plesiosaur"]
#---
