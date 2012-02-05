module Enumerable
  def to_histogram
    inject(Hash.new(0)) { |h, x| h[x] += 1; h}
  end 
end

[1, 2, 2, 2, 3, 3].to_histogram
# => {1=>1, 2=>3, 3=>2}

["a", "b", nil, "c", "b", nil, "a"].to_histogram
# => {"a"=>2, "b"=>2, "c"=>1, nil=>2}

"Aye\nNay\nNay\nAbstaining\nAye\nNay\nNot Present\n".to_histogram
# => {"Abstaining\n"=>1, "Nay\n"=>3, "Not Present\n"=>1, "Aye\n"=>2}

survey_results = { "Alice" => :red, "Bob" => :green, "Carol" => :green,
                   "Mallory" => :blue }
survey_results.values.to_histogram
# => {:red=>1, :green=>2, :blue=>1}
#---
def draw_graph(histogram, char="#")	    
  pairs = histogram.keys.collect { |x| [x.to_s, histogram[x]] }.sort
#---
  largest_key_size = pairs.max { |x,y| x[0].size <=> y[0].size }[0].size
#---
  pairs.inject("") do |s,kv| 
    s << "#{kv[0].ljust(largest_key_size)} |#{char*kv[1]}\n"    
  end
end
#---
puts draw_graph(survey_results.values.to_histogram)
# blue  |#
# green |##
# red   |#
#---
random = []
100.times { random << rand(10) }
puts draw_graph(random.to_histogram)
# 0 |############
# 1 |########
# 2 |#######
# 3 |#########
# 4 |##########
# 5 |#############
# 6 |###############
# 7 |########
# 8 |#######
# 9 |###########
#---
