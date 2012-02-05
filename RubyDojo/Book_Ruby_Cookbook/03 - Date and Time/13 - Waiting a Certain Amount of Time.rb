3.downto(1) { |i| puts "#{i}..."; sleep(1) }; puts "Go!"
# 3...
# 2...
# 1...
# Go!

Time.new                     # => Sat Mar 18 21:17:58 EST 2006
sleep(10)                    
Time.new                     # => Sat Mar 18 21:18:08 EST 2006
sleep(1)
Time.new                     # => Sat Mar 18 21:18:09 EST 2006

# Sleep for less then a second.
Time.new.usec                        # => 377185
sleep(0.1)
Time.new.usec                        # => 479230
#---
interval = 1.0
10.times do |x|
  t1 = Time.new
  sleep(interval)
  actual = Time.new - t1

  difference = (actual-interval).abs
  percent_difference = difference / interval * 100
  printf("Expected: %.9f Actual: %.6f Difference: %.6f (%.2f%%)\n",
         interval, actual, difference, percent_difference)

  interval /= 10
end
# Expected: 1.000000000 Actual: 0.999420 Difference: 0.000580 (0.06%)
# Expected: 0.100000000 Actual: 0.099824 Difference: 0.000176 (0.18%)
# Expected: 0.010000000 Actual: 0.009912 Difference: 0.000088 (0.88%)
# Expected: 0.001000000 Actual: 0.001026 Difference: 0.000026 (2.60%)
# Expected: 0.000100000 Actual: 0.000913 Difference: 0.000813 (813.00%)
# Expected: 0.000010000 Actual: 0.000971 Difference: 0.000961 (9610.00%)
# Expected: 0.000001000 Actual: 0.000975 Difference: 0.000974 (97400.00%)
# Expected: 0.000000100 Actual: 0.000015 Difference: 0.000015 (14900.00%)
# Expected: 0.000000010 Actual: 0.000024 Difference: 0.000024 (239900.00%)
# Expected: 0.000000001 Actual: 0.000016 Difference: 0.000016 (1599900.00%)
#---
alarm = Thread.new(self) { sleep(5); Thread.main.wakeup }
puts "Going to sleep for 1000 seconds at #{Time.new}..."
sleep(10000); puts "Woke up at #{Time.new}!"
# Going to sleep for 1000 seconds at Thu Oct 27 14:45:14 PDT 2005...
# Woke up at Thu Oct 27 14:45:19 PDT 2005!

alarm = Thread.new(self) { sleep(5); Thread.main.wakeup }
puts "Goodbye, cruel world!"; 
Thread.stop; 
puts "I'm back; how'd that happen?"
# Goodbye, cruel world!
# I'm back; how'd that happen?
#---
