rand    # => 0.517297883846589
rand    # => 0.946962603814814
#---
rand(5)            # => 0
rand(5)            # => 4
rand(5)            # => 3
rand(1000)         # => 39
#---
a = ['item1', 'item2', 'item3']
a[rand(a.size)]                     # => "item3"
#---
m = { :key1 => 'value1',
      :key2 => 'value2',
      :key3 => 'value3' }
values = m.values
values[rand(values.size)]            # => "value1"
#---
def random_word
 letters = { ?v => 'aeiou',
             ?c => 'bcdfghjklmnprstvwyz' }
  word = ''
  'cvcvcvc'.each_byte do |x|
    source = letters[x]
    word << source[rand(source.length)].chr
  end
  return word
end

random_word                         # => "josuyip"
random_word                         # => "haramic"
#---
#Some random numbers based on process number and current time
rand(1000)                         # => 187
rand(1000)                         # => 551
rand(1000)                         # => 911

#Start the seed with the number 1
srand 1
rand(1000)                         # => 37
rand(1000)                         # => 235
rand(1000)                         # => 908

#Reset the seed to its previous state
srand 1
rand(1000)                         # => 37
rand(1000)                         # => 235
rand(1000)                         # => 908
#---
