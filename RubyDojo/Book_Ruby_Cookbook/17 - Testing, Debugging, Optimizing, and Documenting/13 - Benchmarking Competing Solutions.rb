RANGE = (0..1000)
array = RANGE.to_a
hash = RANGE.inject({}) { |h,i| h[i] = true; h }

def test_member?(data)
  RANGE.each { |i| data.member? i }
end
#---
require 'benchmark'

Benchmark.bm(5) do |timer|
  timer.report('Array') { test_member?(array) }
  timer.report('Hash') { test_member?(hash) }
end
#        user     system      total        real
# Array  0.260000   0.060000   0.320000 (  0.332583)
# Hash   0.010000   0.000000   0.010000 (  0.001242)
#---
Benchmark.bm(5) do |timer|
  timer.report('Array') { 1000.times { RANGE.each { |i| array[i] } } }
  timer.report('Hash') { 1000.times { RANGE.each { |i| hash[i] } } }
end
#        user     system      total        real
# Array  0.950000   0.210000   1.160000 (  1.175042)
# Hash   1.010000   0.210000   1.220000 (  1.221090)
#---
def write_to_file
  File.open('out', 'w') { |f| f.write('a') }
end

puts Benchmark.measure { 10000.times { write_to_file } }
# 0.120000   0.360000   0.480000 (  0.500653)
#---
