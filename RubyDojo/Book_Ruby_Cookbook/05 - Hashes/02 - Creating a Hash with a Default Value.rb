h = Hash.new
h[1]                                           # => nil
h['do you have this string?']                   # => nil
#---
h = Hash.new("nope")
h[1]                                           # => "nope"
h['do you have this string?']                   # => "nope"
#---
h = Hash.new { |hash, key| (key.respond_to? :to_str) ? "nope" : nil }
h[1]                                           # => nil
h['do you have this string']                   # => "nope"
#---
text = 'The rain in Spain falls mainly in the plain.'
word_count_hash = Hash.new 0
# => {}
text.split(/\W+/).each { |word| word_count_hash[word.downcase] += 1 }
word_count_hash
# => {"rain"=>1, "plain"=>1, "in"=>2, "mainly"=>1, "falls"=>1, 
#     "the"=>2, "spain"=>1}
#---
first_letter_hash = Hash.new []
text.split(/\W+/).each { |word| first_letter_hash[word[0,1].downcase] << word }
first_letter_hash
# => {}
first_letter_hash["m"]
# => ["The", "rain", "in", "Spain", "falls", "mainly", "in", "the", "plain"]
#---
first_letter_hash = Hash.new { |hash, key| hash[key] = [] }
text.split(/\W+/).each { |word| first_letter_hash[word[0,1].downcase] << word }
first_letter_hash
# => {"m"=>["mainly"], "p"=>["plain"], "f"=>["falls"], "r"=>["rain"], 
#     "s"=>["Spain"], "i"=>["in", "in"], "t"=>["The", "the"]}
first_letter_hash["m"]
# => ["mainly"]
#---
