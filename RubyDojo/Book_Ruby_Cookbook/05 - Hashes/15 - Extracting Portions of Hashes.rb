require 'time'
click_counts = {}
1.upto(30) { |i| click_counts[Time.parse("2006-09-#{i}")] = 400 + rand(700) }
p click_counts
# {Sat Sep 23 00:00:00 EDT 2006=>803, Tue Sep 12 00:00:00 EDT 2006=>829, 
#  Fri Sep 01 00:00:00 EDT 2006=>995, Mon Sep 25 00:00:00 EDT 2006=>587,
#  ...
#---
low_click_days = click_counts.select {|key, value| value < 450 }
# [[Thu Sep 14 00:00:00 EDT 2006, 449], [Mon Sep 11 00:00:00 EDT 2006, 406], 
#  [Sat Sep 02 00:00:00 EDT 2006, 440], [Mon Sep 04 00:00:00 EDT 2006, 431],
#  ...
#---
low_click_days_hash = click_counts.inject({}) do |h, kv|
  k, v = kv
  h[k] = v if v < 450
  h
end
# => {Mon Sep 25 00:00:00 EDT 2006=>403, 
#     Wed Sep 06 00:00:00 EDT 2006=>443, 
#     Thu Sep 28 00:00:00 EDT 2006=>419}
#---
low_click_days_hash = Hash[*low_click_days.flatten]
# => {Thu Sep 14 00:00:00 EDT 2006=>449, Mon Sep 11 00:00:00 EDT 2006=>406, 
#     Sat Sep 02 00:00:00 EDT 2006=>440, Mon Sep 04 00:00:00 EDT 2006=>431,
#     ...
#---
