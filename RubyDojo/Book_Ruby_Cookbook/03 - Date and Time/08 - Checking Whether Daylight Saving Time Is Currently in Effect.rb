Time.local(2006, 1, 1)                  # => Sun Jan 01 00:00:00 EST 2006
Time.local(2006, 1, 1).isdst            # => false
Time.local(2006, 10, 1)                 # => Sun Oct 01 00:00:00 EDT 2006
Time.local(2006, 10, 1).isdst           # => true
#---
eastern = Time.local(2006, 10, 1)      # => Sun Oct 01 00:00:00 EDT 2006
eastern.isdst                          # => true

ENV['TZ'] = 'US/Pacific'
pacific = Time.local(2006, 10, 1)      # => Sun Oct 01 00:00:00 PDT 2006
pacific.isdst                          # => true

# Except for the Navajo Nation, Arizona doesn't use Daylight Saving Time.
ENV['TZ'] = 'America/Phoenix'
arizona = Time.local(2006, 10, 1)      # => Sun Oct 01 00:00:00 MST 2006
arizona.isdst                          # => false

# Finally, restore the original time zone.
ENV['TZ'] = nil
#---
# Daylight saving first took effect on March 31, 1918.
Time.local(1918, 3, 31).isdst         # => false
Time.local(1918, 4, 1).isdst          # => true
Time.local(1919, 4, 1).isdst          # => true

# The federal law was repealed later in 1919, but some places
# continued to use Daylight Saving Time:
ENV['TZ'] = 'US/Pacific'
Time.local(1920, 4, 1)                # => Thu Apr 01 00:00:00 PST 1920

ENV['TZ'] = nil
Time.local(1920, 4, 1)                # => Thu Apr 01 00:00:00 EDT 1920

# Daylight Saving Time was reintroduced during the Second World War:
Time.local(1942,2,9)                  # => Mon Feb 09 00:00:00 EST 1942
Time.local(1942,2,10)                 # => Tue Feb 10 00:00:00 EWT 1942
# EWT stands for "Eastern War Time"
#---
Time.local(2007, 3, 13)               # => Tue Mar 13 00:00:00 EDT 2007
# Your computer may incorrectly claim this time is EST.
#---
