array = %w{bob loves alice}
array.collect { |x| x.capitalize }
# => ["Bob", "Loves", "Alice"]
#---
array.collect_reverse { |x| x.capitalize }
# => ["Alice", "Loves", "Bob"]
#---
require 'enumerator'
reversed_array = array.to_enum(:reverse_each)
reversed_array.collect { |x| x.capitalize }
# => ["Alice", "Loves", "Bob"]

reversed_array.each_with_index do |x, i|
  puts %{#{i}=>"#{x}"}
end
# 0=>"alice"
# 1=>"loves"
# 2=>"bob"
#---
reversed_array[0]
# NoMethodError: undefined method `[]' for #<Enumerable::Enumerator:0xb7c2cc8c>
#---
array_with_index = array.enum_with_index
array_with_index.each do |x, i|
  puts %{#{i}=>"#{x}"}
end
# 0=>"bob"
# 1=>"loves"
# 2=>"alice"

array_with_index.each_with_index do |x, i|
  puts %{#{i}=>#{x.inspect}}
end
# 0=>["bob", 0]
# 1=>["loves", 1]
# 2=>["alice", 2]
#---
sentence = %w{Well, now I've seen everything!}

two_word_window = sentence.to_enum(:each_cons, 2)
two_word_window.each { |x| puts x.inspect }
# ["Well,", "now"]
# ["now", "I've"]
# ["I've", "seen"]
# ["seen", "everything!"]

two_words_at_a_time = sentence.to_enum(:each_slice, 2)
two_words_at_a_time.each { |x| puts x.inspect }
# ["Well,", "now"]
# ["I've", "seen"]
# ["everything!"]
#---
