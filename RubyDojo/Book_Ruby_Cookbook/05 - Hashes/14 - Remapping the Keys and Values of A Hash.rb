class Hash
  def tied_with(hash)
    remap do |h,key,value|
      h[hash[key]] = value
  end.delete_if { |key,value| key.nil? || value.nil? }
end
#---
  def remap(hash={})
    each { |k,v| yield hash, k, v }
    hash
  end
end
#---
a = {1 => 2, 3 => 4}
b = {1 => 'foo', 3 => 'bar'}
a.tied_with(b)                      # => {"foo"=>2, "bar" =>4}
b.tied_with(a)                      # => {2=>"foo", 4=>"bar"}
#---
