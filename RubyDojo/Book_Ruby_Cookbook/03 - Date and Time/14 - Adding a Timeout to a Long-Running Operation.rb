# This code will sleep forever... OR WILL IT?
require 'timeout'
before = Time.now
begin
  status = Timeout.timeout(5) { sleep }
rescue Timeout::Error
  puts "I only slept for #{Time.now-before} seconds."
end
# I only slept for 5.035492 seconds.
#---
def count_for_five_seconds
  $counter = 0
  begin
    Timeout::timeout(5) { loop { $counter += 1 } }
  rescue Timeout::Error
    puts "I can count to #{$counter} in 5 seconds."
  end
end

count_for_five_seconds
# I can count to 2532825 in 5 seconds.
$counter                                 # => 2532825
#---
