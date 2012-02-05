hash = { 1 => 'one', [1,2] => 'two', 'three' => 'three' }

hash.each_pair { |key, value| puts "#{key.inspect} maps to #{value}"}
# [1, 2] maps to two
# "three" maps to three
# 1 maps to one
#---
active_toggles = { 'super' => true, 'meta' => true, 'hyper' => true }
active_toggles.each_key { |active| puts active }
# hyper
# meta
# super 
#---
favorite_colors = { 'Alice' => :red, 'Bob' => :violet, 'Mallory' => :blue,
                    'Carol' => :blue, 'Dave' => :violet }

summary = Hash.new(0)
favorite_colors.each_value { |x| summary[x] += 1 }
summary
# => {:red=>1, :violet=>2, :blue=>2}
#---
hash = {}
1.upto(10) { |x| hash[x] = x * x }
hash.has_value? 49                   # => true
hash.has_value? 81                   # => true
hash.has_value? 50                   # => false
#---
1.upto(100) { |x| hash[x] = true }
hash.keys { |k| hash[k * 2] = true }
# RuntimeError: hash modified during iteration
#---
hash = {1 => 2, 2 => 2, 3 => 10}
hash.keys                                    # => [1, 2, 3]
hash.values                                  # => [2, 2, 10]
hash.to_a                                    # => [[1, 2], [2, 2], [3, 10]]
#---
extensions = { 'Alice' => '104', 'Carol' => '210', 'Bob' => '110' }
extensions.keys.sort.each do |k| 
  puts "#{k} can be reached at extension ##{extensions[k]}"
end
# Alice can be reached at extension #104
# Bob can be reached at extension #110
# Carol can be reached at extension #210
#---
to_do = { 'Clean car' => 5, 'Take kangaroo to vet' => 3, 
          'Realign plasma conduit' => 3 }
to_do.sort_by { |task, priority| [priority, task] }.each { |k,v| puts k }
# Realign plasma conduit
# Take kangaroo to vet
# Clean car
#---
transform_results = { 4 => 8, 9 => 9, 10 => 6, 2 => 7, 6 => 5 }
by_size_of_difference = transform_results.sort_by { |x, y| (x-y).abs }
by_size_of_difference.each { |x, y| puts "f(#{x})=#{y}: difference #{y-x}" }
# f(9)=9: difference 0
# f(6)=5: difference -1
# f(10)=6: difference -4
# f(4)=8: difference 4
# f(2)=7: difference 5
#---
