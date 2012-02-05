def fibonacci(limit = nil)
  seed1 = 0
  seed2 = 1
  while not limit or seed2 <= limit
    yield seed2
    seed1, seed2 = seed2, seed1 + seed2
 end
end

fibonacci(3) { |x| puts x }
# 1
# 1
# 2
# 3

fibonacci(1) { |x| puts x }
# 1
# 1

fibonacci { |x| break if x > 20; puts x }
# 1
# 1
# 2
# 3
# 5
# 8
# 13
#---
class Range
  def each_slow
    x = self.begin
    while x <= self.end
      yield x
      x = x.succ
    end    
  end
end

(1..3).each_slow {|x| puts x}
# 1
# 2
# 3
#---
class Fixnum
  def double_upto(stop)
    x = self
    until x > stop
      yield x
     x = x * 2
    end
  end
end
10.double_upto(50) { |x| puts x }
# 10
# 20
# 40
#---
def oscillator
  x = 1
  while true
    yield x
    x *= -2
  end
end
oscillator { |x| puts x; break if x.abs > 50; }
# 1
# -2
# 4
# -8
# 16
# -32
# 64
#---
1.5.step(2.0, 0.25) { |x| puts x }
# => 1.5
# => 1.75
# => 2.0
#---
def zeno(start, stop)
  distance = stop - start
  travelled = start
  while travelled < stop and distance > 0
    yield travelled
    distance = distance / 2.0
    travelled += distance
  end
end

steps = 0
zeno(0, 1) { steps += 1 }
steps                                                  # => 54
#---
