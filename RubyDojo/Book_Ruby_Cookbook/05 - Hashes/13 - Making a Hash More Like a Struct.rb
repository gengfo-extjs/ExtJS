require 'rubygems'
require 'facet/hash/to_ostruct'

cliches = { 'hammer' => 'tongs', :lock => ['stock', 'barrel'] }
cliches_struct = cliches.to_ostruct

cliches_struct.hammer                          # => "tongs"
cliches_struct.lock                            # => ["stock", "barrel"]
cliches_struct.rolling_stone                   # => nil
#---
class StructlikeHash < Hash
  def method_missing(name, *args)
    if include?(name)
      self[name]
    elsif include?(name.to_s)
      self[name.to_s]
    else
      super
    end
  end
end
#---
cliches = StructlikeHash['cat' => 'mouse', 'grin' => { 'bear' => 'it' } ]
cliches.cat                        # => "mouse"
cliches.creek                      
# NoMethodError: undefined method `creek' for {"cat"=>"mouse", "grin"=>{"bear"=>"it"}}:StructlikeHash
#---
class StructlikeHash2 < Hash
  def method_missing(name, *args)
    if include?(name)
      self[name]
    elsif include?(name.to_s)
      self[name.to_s]
    else
      begin
        super
      rescue NoMethodError 
        nil
      end
    end
  end
end

cliches = StructlikeHash2['cat' => 'mouse', 'grin' => { 'bear' => 'it' } ]
cliches.creek                                     # => nil
#---
cliches[:keys] = 'to the kingdom'
cliches[1] = 'and only'
cliches[:top] = 'of the world'
cliches["top"] = 'to bottom'

cliches.keys                           # => ["cat", :top, 1, "grin", "top", :keys]
cliches.top                            # => "of the world"
cliches.1                              
# SyntaxError: compile error
#---
