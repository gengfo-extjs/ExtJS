phone_directory = {  'Alice' => '555-1212',
                     'Bob' => '555-1313',
                     'Mallory' => '111-1111' }
phone_directory.invert
# => {"111-1111"=>"Mallory", "555-1212"=>"Alice", "555-1313"=>"Bob"}
#---
phone_directory = {  'Alice' => '555-1212',
                     'Bob' => '555-1313',
                     'Carol' => '555-1313',
                     'Mallory' => '111-1111',
                     'Ted' => '555-1212' }
phone_directory.invert
# => {"111-1111"=>"Mallory", "555-1212"=>"Ted", "555-1313"=>"Bob"}
#---
class Hash
  def safe_invert
    new_hash = {}
    self.each do |k,v|
      if v.is_a? Array
        v.each { |x| new_hash.add_or_append(x, k) }
      else
        new_hash.add_or_append(v, k)
      end
    end
    return new_hash
  end
#---
  def add_or_append(key, value)
    if has_key?(key)      
      self[key] = [value, self[key]].flatten
    else
      self[key] = value
    end    
  end
end
#---
phone_directory.safe_invert
# => {"111-1111"=>"Mallory", "555-1212"=>["Ted", "Alice"], 
#     "555-1313"=>["Bob", "Carol"]}

phone_directory.safe_invert.safe_invert
# => {"Alice"=>"555-1212", "Mallory"=>"111-1111", "Ted"=>"555-1212", "Carol"=>"555-1313", "Bob"=>"555-1313"}
#---
