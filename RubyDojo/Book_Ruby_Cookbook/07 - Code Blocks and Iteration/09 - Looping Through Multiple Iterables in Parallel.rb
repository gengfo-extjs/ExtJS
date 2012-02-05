require 'generator'

enumerator = SyncEnumerator.new(%w{Four seven}, %w{score years}, 
            	                %w{and ago})
enumerator.each do |row|
  row.each { |word| puts word }
  puts '---'
end
# Four
# score
# and
# ---
# seven
# years
# ago
# ---

enumerator = SyncEnumerator.new(%w{Four and}, %w{score seven years ago})
enumerator.each do |row|
  row.each { |word| puts word }
  puts '---'
end
# Four
# score
# ---
# and
# seven
# ---
# nil
# years
# ---
# nil
# ago
# ---
#---
def interosculate(*enumerables)
  generators = enumerables.collect { |x| Generator.new(x) }
  done = false
  until done	
    done = true
    generators.each do |g|
      if g.next?
        yield g.next
        done = false
      end
    end
  end
end

interosculate(%w{Four and}, %w{score seven years ago}) do |x|
  puts x
end
# Four
# score
# and
# seven
# years
# ago
#---
l = ["junk1", 1, "junk2", 2, "junk3", "junk4", 3, "junk5"]
#---
g = Generator.new(l)
g.next                                # => "junk1"
g.next                                # => 1
g.next                                # => "junk2"
#---
def l.my_iterator
  each { |e| yield e unless e =~ /^junk/ }
end

l.my_iterator { |x| puts x }
# 1
# 2
# 3
#---
g = Generator.new { |g| l.each { |e| g.yield e unless e =~ /^junk/ } }
g.next                                            # => 1
g.next                                            # => 2
g.next                                            # => 3
#---
g = Generator.new { |g| l.my_iterator { |e| g.yield e } }
g.next                                           # => 1
g.next                                           # => 2
g.next                                           # => 3
#---
def interosculate(*iteratables)
  generators = iteratables.collect do |x| 
    if x.is_a? Method
      Generator.new { |g| x.call { |e| g.yield e } }
    else
      Generator.new(x) 
    end
  end
  done = false
  until done	
    done = true
    generators.each do |g|
      if g.next?
        yield g.next
        done = false
      end
    end
  end
end
#---
words1 = %w{Four and years}
words2 = %w{ago seven score}
interosculate(words1, words2.method(:reverse_each)) { |x| puts x }
# Four
# score
# and
# seven
# years
# ago
#---
